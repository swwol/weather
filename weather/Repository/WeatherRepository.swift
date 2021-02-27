import Combine
import Foundation

protocol WeatherRepositoryType {
	func getWeather(for city: City) -> AnyPublisher<WeatherResponse, Error>
}

final class WeatherRepository: WeatherRepositoryType {

	enum Error: Swift.Error {
		case weatherApiError
	}

	enum API {
		static let scheme = "https"
		static let host = "api.openweathermap.org"
		static let path = "/data/2.5/weather"
		static let key = "af080064899d63e4d2552118e176863b"
	}

	func getWeather(for city: City) -> AnyPublisher<WeatherResponse, Swift.Error> {

		var components = URLComponents()
		components.scheme = API.scheme
		components.host = API.host
		components.path = API.path
		components.queryItems = [
			URLQueryItem(name: "id", value: city.id),
			URLQueryItem(name: "appId", value: API.key),
			URLQueryItem(name: "units", value: "metric")
		]

		guard let url = components.url else {
			fatalError("error constructing url")
		}

		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap {
				guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
					throw Error.weatherApiError
				}
				return $0.data
			}
			.decode(type: WeatherResponse.self, decoder: JSONDecoder())
			.eraseToAnyPublisher()
	}
}

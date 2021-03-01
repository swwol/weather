import Combine
import Foundation
@testable import weather

final class FakeWeatherRepository: WeatherRepositoryType {

	var getWeatherError: Error?
	var getweatherResponse: WeatherResponse = .fake()

	func getWeather(for city: City) -> AnyPublisher<WeatherResponse, Error> {
		return Future<WeatherResponse, Error> { promise in
			if let error = self.getWeatherError {
				promise(.failure(error))
			} else {
				promise(.success(self.getweatherResponse))
			}
		}
		.eraseToAnyPublisher()
	}
}

extension WeatherResponse {
	static func fake() -> WeatherResponse {
		return WeatherResponse(coord: .init(lon: 1, lat: 1),
							   weather: [.init(id: 1, main: "test", description: "test", icon: .clearDay)],
							   properties: .init(temp: 1, feels: 1, min: 1, max: 1, pressure: 1, humidity: 1),
							   visibility: 1,
							   wind: .init(speed: 1, deg: 1),
							   clouds: .init(all: 1),
							   rain: nil,
							   snow: nil)
	}
}

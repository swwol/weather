import Foundation

struct WeatherResponse: Decodable, Equatable {

	enum WeatherIcon: String, Decodable {
	 case thunder = "11d"
	 case drizzle = "09d"
	 case rain = "10d"
	 case snow = "13d"
	 case atmosphere = "50d"
	 case atmosphereNight = "50n"
	 case clearDay = "01d"
	 case clearNight = "01n"
	 case fewCloudsDay = "02d"
	 case fewCloudsNight = "02n"
	 case scatteredCloudsDay = "03d"
	 case scatteredCloudsNight = "03n"
	 case overcastDay = "04d"
	 case overcasetNight = "04n"

	 var sfSymbolName: String {
		 switch self {
		 case .thunder:
			 return "cloud.bolt.rain"
		 case .drizzle:
			 return "cloud.drizzle"
		 case .rain:
			 return "cloud.rain"
		 case .snow:
			 return "cloud.snow"
		 case .atmosphere, .atmosphereNight:
			 return "cloud.fog"
		 case .clearDay:
			 return "sun.max"
		 case .clearNight:
			 return "moon"
		 case .fewCloudsDay, .scatteredCloudsDay, .overcastDay:
			 return "cloud.sun"
		 case .fewCloudsNight, .scatteredCloudsNight, .overcasetNight:
			 return "cloud.moon"
		 }
	 }
		var gradient: Gradient {
			switch self {
			case .thunder:
				return .thunder
			case .drizzle, .rain:
				return .rain
			case .snow:
				return .snow
			case .clearDay, .clearNight:
				return .sunny
			default:
				return .cloud
			}
		}
 }

	struct Coord: Decodable, Equatable {
		let lon: Double
		let lat: Double
	}

	struct Weather: Decodable, Equatable {
		// swiftlint:disable:next identifier_name
		let id: Int
		let main: String
		let description: String
		let icon: WeatherIcon
	}

	struct WeatherProperites: Decodable, Equatable {
		let temp: Double
		let feels: Double
		let min: Double
		let max: Double
		let pressure: Int
		let humidity: Int
		// swiftlint:disable:next nesting
		enum CodingKeys: String, CodingKey {
			case temp
			case feels = "feels_like"
			case min = "temp_min"
			case max = "temp_max"
			case pressure
			case humidity
		}
	}

	struct Wind: Decodable, Equatable {
		let speed: Double
		let deg: Int
	}

	struct Clouds: Decodable, Equatable {
		let all: Int
	}

	struct Volume: Decodable, Equatable {
		let oneHour: Double?
		let threeHour: Double?
		// swiftlint:disable:next nesting
		enum CodingKeys: String, CodingKey {
			case oneHour = "1h"
			case threeHour = "3h"
		}
	}

	let coord: Coord
	let weather: [Weather]
	let properties: WeatherProperites
	let visibility: Int
	let wind: Wind
	let clouds: Clouds
	let rain: Volume?
	let snow: Volume?

	enum CodingKeys: String, CodingKey {
		case coord
		case weather
		case properties = "main"
		case visibility
		case wind
		case clouds
		case rain
		case snow
	}
}

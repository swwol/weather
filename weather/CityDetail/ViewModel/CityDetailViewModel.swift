import Combine
import UIKit

protocol CityDetailViewModelOutputsType {
	var gradient: AnyPublisher<Gradient, Never> { get }
}

protocol CityDetailViewModelInputsType {}

protocol CityDetailViewModelType {
	var inputs: CityDetailViewModelInputsType { get }
	var outputs: CityDetailViewModelOutputsType { get }
}

final class CityDetailViewModel: CityDetailViewModelType, CityDetailViewModelInputsType, CityDetailViewModelOutputsType {
	var inputs: CityDetailViewModelInputsType { return self }
	var outputs: CityDetailViewModelOutputsType { return self }

	enum State: Equatable {
		case loading
		case complete(WeatherResponse)
		case failure
	}

	let gradient: AnyPublisher<Gradient, Never>

	init(repository: WeatherRepositoryType, weather: WeatherResponse?, localizer: StringLocalizing = Localizer()) {
		gradient = Just(.cityDetailBG).eraseToAnyPublisher()

		if let weather = weather {
		}
	}
}

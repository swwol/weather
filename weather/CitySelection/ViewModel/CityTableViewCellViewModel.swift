import Combine
import UIKit

protocol CityTableViewCellViewModelOutputsType {
	var cityName: AnyPublisher<String?, Never> { get }
	var temp: AnyPublisher<String?, Never> { get }
	var gradient: AnyPublisher<Gradient, Never> { get }
	var state: AnyPublisher<CityTableViewCellViewModel.State, Never> { get }
	var icon: AnyPublisher<UIImage?, Never> { get }
}

protocol CityTableViewCellViewModelInputsType {
	func fetchWeather()
}

protocol CityTableViewCellViewModelType {
	var outputs: CityTableViewCellViewModelOutputsType { get }
	var inputs: CityTableViewCellViewModelInputsType { get }
}

final class CityTableViewCellViewModel: CityTableViewCellViewModelType, CityTableViewCellViewModelOutputsType, CityTableViewCellViewModelInputsType {

	enum State: Equatable {
		case loading
		case complete(WeatherResponse)
		case failure
	}

	var outputs: CityTableViewCellViewModelOutputsType { self }
	var inputs: CityTableViewCellViewModelInputsType { self }

	let cityName: AnyPublisher<String?, Never>
	let temp: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>
	let icon: AnyPublisher<UIImage?, Never>

	var state: AnyPublisher<State, Never> {
		statePublisher.eraseToAnyPublisher()
	}

	private let repository: WeatherRepositoryType
	private let city: City
	private let statePublisher = PassthroughSubject<State, Never>()
	private var cancellables = Set<AnyCancellable>()

	init(city: City, repository: WeatherRepositoryType, localizer: StringLocalizing = Localizer()) {
		self.city = city
		self.repository = repository
		self.cityName = Just(localizer.localize(city.localizedKey))
			.eraseToAnyPublisher()
		gradient = Just(.sunny).eraseToAnyPublisher()

		self.temp = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return "-"
			case let .complete(weather):
				return "\(weather.properties.temp)c"
			}
		}
		.eraseToAnyPublisher()

		self.icon = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return nil
			case let .complete(response):
				guard let weather = response.weather.first else {
					return nil
				}
				return UIImage(systemName: weather.icon.sfSymbolName)
			}
		}
		.eraseToAnyPublisher()
	}

	func fetchWeather() {
		statePublisher.send(.loading)
		repository
			.getWeather(for: city)
			.receive(on: DispatchQueue.main)
			.sink(receiveCompletion: { [weak self] completion in
				guard let self = self else { return }
				switch completion {
				case .finished:
					break
				case .failure:
					self.statePublisher.send(.failure)
				}
			},receiveValue: { weather in
				self.statePublisher.send(.complete(weather))
			})
			.store(in: &cancellables)
	}
}


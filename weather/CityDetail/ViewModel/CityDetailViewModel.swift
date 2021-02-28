import Combine
import UIKit

protocol CityDetailViewModelOutputsType {
	var gradient: AnyPublisher<Gradient, Never> { get }
	var icon: AnyPublisher<UIImage?, Never> { get }
	var temp: AnyPublisher<String?, Never> { get }
	var cityName: AnyPublisher<String?, Never> { get }
	var weatherDescription: AnyPublisher<String?, Never> { get }
	var feelLike: AnyPublisher<String?, Never> { get }
	var highLow: AnyPublisher<String?, Never> { get }
}

protocol CityDetailViewModelInputsType {
	func viewDidDissappear()
}

protocol CityDetailViewModelType {
	var inputs: CityDetailViewModelInputsType { get }
	var outputs: CityDetailViewModelOutputsType { get }
}

final class CityDetailViewModel: CityDetailViewModelType, CityDetailViewModelInputsType, CityDetailViewModelOutputsType {

	enum State: Equatable {
		case loading
		case complete(WeatherResponse)
		case failure
	}

	var inputs: CityDetailViewModelInputsType { return self }
	var outputs: CityDetailViewModelOutputsType { return self }

	let icon: AnyPublisher<UIImage?, Never>
	let temp: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>
	let cityName: AnyPublisher<String?, Never>
	let weatherDescription: AnyPublisher<String?, Never>
	let feelLike: AnyPublisher<String?, Never>
	let highLow: AnyPublisher<String?, Never>
	private let repository: WeatherRepositoryType
	private let city: City
	private let statePublisher: CurrentValueSubject<State, Never>
	private var cancellables = Set<AnyCancellable>()
	private let timer: IntervalTimerType

	init(city: City,
		 repository: WeatherRepositoryType,
		 weather: WeatherResponse?,
		 timer: IntervalTimerType = IntervalTimer(interval: 5),
		 localizer: StringLocalizing = Localizer()) {
		self.timer = timer
		self.repository = repository
		self.city = city
		gradient = Just(.cityDetailBG).eraseToAnyPublisher()
		cityName = Just(localizer.localize(city.localizedKey))
			.eraseToAnyPublisher()

		if let weather = weather {
			statePublisher = CurrentValueSubject(.complete(weather))
		}
		else {
			statePublisher = CurrentValueSubject(.loading)
		}

		temp = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return "-"
			case let .complete(weather):
				return "\(weather.properties.temp)c"
			}
		}
		.eraseToAnyPublisher()

		icon = statePublisher.map { state in
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

		weatherDescription = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return "-"
			case let .complete(response):
				guard let weather = response.weather.first else {
					return "-"
				}
				return weather.description
			}
		}
		.eraseToAnyPublisher()

		feelLike = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return "-"
			case let .complete(response):
				return localizer.localize("weather.details.feels.like %@", "\(response.properties.feels)")
			}
		}
		.eraseToAnyPublisher()

		highLow = statePublisher.map { state in
			switch state {
			case .loading, .failure:
				return "-"
			case let .complete(response):
				return localizer.localize("weather.details.high.low %@ %@",
										  "\(response.properties.max)",
										  "\(response.properties.min)")
			}
		}
		.eraseToAnyPublisher()

		if statePublisher.value == .loading {
			fetchWeather()
		}

		timer.publisher.sink { [weak self] _ in
			self?.fetchWeather()
		}
		.store(in: &cancellables)

		timer.start()
	}

	func viewDidDissappear() {
		timer.stop()
	}

	private func fetchWeather() {
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

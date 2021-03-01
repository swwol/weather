import Combine
import UIKit

protocol CitySelectionViewModelDelegate: AnyObject {
	func didSelect(city: City, weather: WeatherResponse?, on viewModel: CitySelectionViewModelType)
}

protocol CitySelectionViewModelInputsType {
	func viewDidAppear()
	func viewDidDisappear()
}

protocol CitySelectionViewModelOutputsType {
	var dataSource: AnyPublisher<CityDataSource, Never> { get }
	var title: AnyPublisher<String?, Never> { get }
	var gradient: AnyPublisher<Gradient, Never> { get }
}

protocol CitySelectionViewModelType {
	var inputs: CitySelectionViewModelInputsType { get }
	var outputs: CitySelectionViewModelOutputsType { get }
	var delegate: CitySelectionViewModelDelegate? { get set }
}

final class CitySelectionViewModel: CitySelectionViewModelType,
									CitySelectionViewModelInputsType,
									CitySelectionViewModelOutputsType {
	var inputs: CitySelectionViewModelInputsType { return self }
	var outputs: CitySelectionViewModelOutputsType { return self }
	let dataSource: AnyPublisher<CityDataSource, Never>
	let title: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>
	private let timer: IntervalTimerType
	private var cancellable: AnyCancellable?
	private let cityDataSource: CityDataSource

	weak var delegate: CitySelectionViewModelDelegate?

	init(
		repository: WeatherRepositoryType,
		timer: IntervalTimerType = IntervalTimer(interval: 5),
		localizer: StringLocalizing = Localizer()
	) {
		cityDataSource = CityDataSource(repository: repository)
		dataSource = Just(cityDataSource).eraseToAnyPublisher()
		title = Just(localizer.localize("city.selection.title")).eraseToAnyPublisher()
		gradient = Just(.citySelectorBG).eraseToAnyPublisher()
		self.timer = timer

		cancellable = timer.publisher.sink { [weak self] _ in
			self?.cityDataSource.updateVisibleCells()
		}

		cityDataSource.delegate = self
	}

	func viewDidAppear() {
		timer.start()
	}

	func viewDidDisappear() {
		timer.stop()
	}
}

extension CitySelectionViewModel: CityDataSourceDelegate {
	func didSelect(city: City, weather: WeatherResponse?, on dataSource: CityDataSource) {
		delegate?.didSelect(city: city, weather: weather, on: self)
	}
}

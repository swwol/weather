import Combine
import UIKit

protocol CitySelectionViewModelInputsType {
	func viewDidAppear()
}

protocol CitySelectionViewModelOutputsType {
	var dataSource: AnyPublisher<CityDataSource, Never> { get }
	var title: AnyPublisher<String?, Never> { get }
	var gradient: AnyPublisher<Gradient, Never> { get }
}

protocol CitySelectionViewModelType {
	var inputs: CitySelectionViewModelInputsType { get }
	var outputs: CitySelectionViewModelOutputsType { get }
}

final class CitySelectionViewModel: CitySelectionViewModelType, CitySelectionViewModelInputsType, CitySelectionViewModelOutputsType {
	var inputs: CitySelectionViewModelInputsType { return self }
	var outputs: CitySelectionViewModelOutputsType { return self }
	let dataSource: AnyPublisher<CityDataSource, Never>
	let title: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>

	init(repository: WeatherRepositoryType, localizer: StringLocalizing = Localizer()) {
		dataSource = Just(CityDataSource(repository: repository)).eraseToAnyPublisher()
		title = Just(localizer.localize("city.selection.title")).eraseToAnyPublisher()
		gradient = Just(.citySelectorBG).eraseToAnyPublisher()
	}

	func viewDidAppear() {
	}
}

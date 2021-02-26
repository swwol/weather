import Combine
import UIKit

protocol CitySelectionViewModelInputsType {
	func viewDidAppear()
}

protocol CitySelectionViewModelOutputsType {
	var dataSource: AnyPublisher<CityDataSource, Never> { get }
}

protocol CitySelectionViewModelType {
	var inputs: CitySelectionViewModelInputsType { get }
	var outputs: CitySelectionViewModelOutputsType { get }
}

final class CitySelectionViewModel: CitySelectionViewModelType, CitySelectionViewModelInputsType, CitySelectionViewModelOutputsType {

	var inputs: CitySelectionViewModelInputsType { return self }
	var outputs: CitySelectionViewModelOutputsType { return self }
	let dataSource: AnyPublisher<CityDataSource, Never>

	init() {
		dataSource = Just(CityDataSource()).eraseToAnyPublisher()
	}

	func viewDidAppear() {
	}
}

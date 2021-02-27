import Combine
import UIKit

protocol CitySelectionViewModelDelegate: AnyObject {
	func didSelect(city: City, on viewModel: CitySelectionViewModelType)
}

protocol CitySelectionViewModelInputsType {
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

final class CitySelectionViewModel: CitySelectionViewModelType, CitySelectionViewModelInputsType, CitySelectionViewModelOutputsType {
	var inputs: CitySelectionViewModelInputsType { return self }
	var outputs: CitySelectionViewModelOutputsType { return self }
	let dataSource: AnyPublisher<CityDataSource, Never>
	let title: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>

	weak var delegate: CitySelectionViewModelDelegate?

	init(repository: WeatherRepositoryType, localizer: StringLocalizing = Localizer()) {
		let cityDataSource = CityDataSource(repository: repository)
		dataSource = Just(cityDataSource).eraseToAnyPublisher()
		title = Just(localizer.localize("city.selection.title")).eraseToAnyPublisher()
		gradient = Just(.citySelectorBG).eraseToAnyPublisher()
		cityDataSource.delegate = self
	}
}

extension CitySelectionViewModel: CityDataSourceDelegate {
	func didSelect(city: City, on dataSource: CityDataSource) {
		delegate?.didSelect(city: city, on: self)
	}
}

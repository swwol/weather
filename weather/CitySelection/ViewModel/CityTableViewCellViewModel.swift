import Combine
import UIKit

protocol CityTableViewCellViewModelOutputsType {
	var cityLabel: AnyPublisher<String?, Never> { get }
}

protocol CityTableViewCellViewModelType {
	var outputs: CityTableViewCellViewModelOutputsType { get }
}

final class CityTableViewCellViewModel: CityTableViewCellViewModelType, CityTableViewCellViewModelOutputsType {

	var outputs: CityTableViewCellViewModelOutputsType { self }

	let cityLabel: AnyPublisher<String?, Never>

	init(city: City, localizer: StringLocalizing = Localizer()) {
		self.cityLabel = Just(localizer.localize(city.localizedKey))
			.eraseToAnyPublisher()
	}
}

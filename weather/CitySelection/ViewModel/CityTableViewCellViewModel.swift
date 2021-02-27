import Combine
import UIKit

protocol CityTableViewCellViewModelOutputsType {
	var city: AnyPublisher<String?, Never> { get }
	var temp: AnyPublisher<String?, Never> { get }
	var gradient: AnyPublisher<Gradient, Never> { get }
}

protocol CityTableViewCellViewModelType {
	var outputs: CityTableViewCellViewModelOutputsType { get }
}

final class CityTableViewCellViewModel: CityTableViewCellViewModelType, CityTableViewCellViewModelOutputsType {

	var outputs: CityTableViewCellViewModelOutputsType { self }

	let city: AnyPublisher<String?, Never>
	let temp: AnyPublisher<String?, Never>
	let gradient: AnyPublisher<Gradient, Never>

	init(city: City, localizer: StringLocalizing = Localizer()) {
		self.city = Just(localizer.localize(city.localizedKey))
			.eraseToAnyPublisher()
		self.temp = Just("23c").eraseToAnyPublisher()
		gradient = Just(.sunny).eraseToAnyPublisher()

	}
}

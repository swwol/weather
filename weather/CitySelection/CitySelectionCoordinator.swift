import UIKit

protocol CitySelectionCoordinatorDelegate: AnyObject {
	func didSelect(city: City, weather: WeatherResponse?, on coordinator: CitySelectionCoordinatorType)
}

protocol CitySelectionCoordinatorType: AnyObject {
	func start(on context: UINavigationController)
	var delegate: CitySelectionCoordinatorDelegate? { get set }
}

final class CitySelectionCoordinator: CitySelectionCoordinatorType {
	private let repository: WeatherRepositoryType

	weak var delegate: CitySelectionCoordinatorDelegate?

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}

	func start(on context: UINavigationController) {
		let viewModel = CitySelectionViewModel(repository: repository)
		viewModel.delegate = self
		let viewController: CitySelectionViewController = .fromStoryboard()
		viewController.viewModel = viewModel
		context.setViewControllers([viewController], animated: false)
	}
}

extension CitySelectionCoordinator: CitySelectionViewModelDelegate {
	func didSelect(city: City, weather: WeatherResponse?, on viewModel: CitySelectionViewModelType) {
		delegate?.didSelect(city: city, weather: weather, on: self)
	}
}

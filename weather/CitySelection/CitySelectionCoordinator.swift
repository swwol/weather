import UIKit

protocol CitySelectionCoordinatorType {
	func start(on context: UINavigationController)
}

final class CitySelectionCoordinator: CitySelectionCoordinatorType {

	private let repository: WeatherRepositoryType

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}

	func start(on context: UINavigationController) {
		let viewModel = CitySelectionViewModel(repository: repository)
		let viewController: CitySelectionViewController = .fromStoryboard()
		viewController.viewModel = viewModel
		context.setViewControllers([viewController], animated: false)
	}
}

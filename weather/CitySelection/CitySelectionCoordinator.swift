import UIKit

protocol CitySelectionCoordinatorType {
	func start(on context: UINavigationController)
}

final class CitySelectionCoordinator: CitySelectionCoordinatorType {
	func start(on context: UINavigationController) {
		let viewModel = CitySelectionViewModel()
		let viewController: CitySelectionViewController = .fromStoryboard()
		viewController.viewModel = viewModel
		context.setViewControllers([viewController], animated: false)
	}
}

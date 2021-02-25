import UIKit

protocol CitySelectionCoordinatorType {
	func start(on context: UINavigationController)
}

final class CitySelectionCoordinator: CitySelectionCoordinatorType {
	func start(on context: UINavigationController) {
		let viewController: CitySelectionViewController = .fromStoryboard()
		context.setViewControllers([viewController], animated: false)
	}
}

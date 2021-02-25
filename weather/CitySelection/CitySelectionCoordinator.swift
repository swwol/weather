import UIKit

protocol CitySelectionCoordinatorType {
	func start(on context: UINavigationController)
}

final class CitySelectionCoordinator: CitySelectionCoordinatorType {
	func start(on context: UINavigationController) {
		let viewController = UIViewController()
		viewController.view.backgroundColor = .red
		context.setViewControllers([viewController], animated: false)
	}
}

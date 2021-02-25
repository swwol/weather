import UIKit

protocol AppCoordinatorType {
	func start(on context: UINavigationController)
}

final class AppCoordinator: AppCoordinatorType {
	private let citySelectionCoordinator: CitySelectionCoordinatorType
	private var context: UINavigationController!
	init(citySelectionCoordinator: CitySelectionCoordinatorType) {
		self.citySelectionCoordinator = citySelectionCoordinator
	}
	func start(on context: UINavigationController) {
		self.context = context
		citySelectionCoordinator.start(on: context)
	}
}

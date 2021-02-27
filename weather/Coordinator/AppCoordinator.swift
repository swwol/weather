import UIKit

protocol AppCoordinatorType {
	func start(on context: UINavigationController)
}

final class AppCoordinator: AppCoordinatorType {
	private let citySelectionCoordinator: CitySelectionCoordinatorType
	private let cityDetailCoordinator: CityDetailCoordinatorType
	private var context: UINavigationController!
	init(citySelectionCoordinator: CitySelectionCoordinatorType,
		 cityDetailCoordinator: CityDetailCoordinatorType) {
		self.citySelectionCoordinator = citySelectionCoordinator
		self.cityDetailCoordinator = cityDetailCoordinator
	}
	func start(on context: UINavigationController) {
		self.context = context
		citySelectionCoordinator.start(on: context)
	}
}

extension AppCoordinator: CitySelectionCoordinatorDelegate {
	func didSelect(city: City, on coordinator: CitySelectionCoordinatorType) {
		cityDetailCoordinator.start(with: city, on: context)
	}
}

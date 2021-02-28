import UIKit

protocol AppCoordinatorType {
	func start(on context: UINavigationController)
}

final class AppCoordinator: NSObject, AppCoordinatorType {
	private let citySelectionCoordinator: CitySelectionCoordinatorType
	private let cityDetailCoordinator: CityDetailCoordinatorType
	private var context: UINavigationController!
	init(citySelectionCoordinator: CitySelectionCoordinatorType,
		 cityDetailCoordinator: CityDetailCoordinatorType) {
		self.citySelectionCoordinator = citySelectionCoordinator
		self.cityDetailCoordinator = cityDetailCoordinator
		super.init()
		citySelectionCoordinator.delegate = self
	}
	func start(on context: UINavigationController) {
		self.context = context
		context.delegate = self
		citySelectionCoordinator.start(on: context)
	}
}

extension AppCoordinator: CitySelectionCoordinatorDelegate {
	func didSelect(city: City, weather: WeatherResponse?, on coordinator: CitySelectionCoordinatorType) {
		cityDetailCoordinator.start(with: city, weather: weather, on: context)
	}
}

extension AppCoordinator: UINavigationControllerDelegate {
	func navigationController(
		_ navigationController: UINavigationController,
		willShow viewController: UIViewController,
		animated: Bool
	) {
		viewController.navigationItem.backBarButtonItem = UIBarButtonItem(
			title: "",
			style: .plain,
			target: nil,
			action: nil)
	}
}

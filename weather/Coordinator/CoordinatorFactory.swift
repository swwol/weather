import Foundation

struct CoordinatorFactory {
	func makeApp() -> AppCoordinatorType {
		AppCoordinator(citySelectionCoordinator: makeCitySelection())
	}

	func makeCitySelection() -> CitySelectionCoordinatorType {
		CitySelectionCoordinator()
	}
}

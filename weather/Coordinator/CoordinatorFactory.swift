import Foundation

struct CoordinatorFactory {

	private let repository: WeatherRepositoryType

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}
	func makeApp() -> AppCoordinatorType {
		AppCoordinator(citySelectionCoordinator: makeCitySelection())
	}

	func makeCitySelection() -> CitySelectionCoordinatorType {
		CitySelectionCoordinator(repository: repository)
	}
}

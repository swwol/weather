import Foundation

struct CoordinatorFactory {

	private let repository: WeatherRepositoryType

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}
	func makeApp() -> AppCoordinatorType {
		AppCoordinator(citySelectionCoordinator: makeCitySelection(),
					   cityDetailCoordinator: makeCityDetail())
	}

	func makeCitySelection() -> CitySelectionCoordinatorType {
		CitySelectionCoordinator(repository: repository)
	}

	func makeCityDetail() -> CityDetailCoordinatorType {
		CityDetailCoordinator(repository: repository)
	}
}

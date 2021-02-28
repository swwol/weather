import UIKit

protocol CityDetailCoordinatorType {
	func start(with city: City, weather: WeatherResponse?, on context: UINavigationController)
}

final class CityDetailCoordinator: CityDetailCoordinatorType {
	private let repository: WeatherRepositoryType

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}

	func start(with city: City, weather: WeatherResponse?, on context: UINavigationController) {
		let viewModel = CityDetailViewModel(city: city, repository: repository, weather: weather)
		let viewController: CityDetailViewController = .fromStoryboard()
		viewController.viewModel = viewModel
		context.pushViewController(viewController, animated: true)
	}
}

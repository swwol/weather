@testable import weather

final class MockCitySelectionViewModelDelegate: CitySelectionViewModelDelegate {
	var spyDidSelect: [(City, WeatherResponse?)] = []
	func didSelect(city: City, weather: WeatherResponse?, on viewModel: CitySelectionViewModelType) {
		spyDidSelect.append((city, weather))
	}
}

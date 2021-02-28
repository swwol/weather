import XCTest
@testable import weather

final class CityTableViewCellViewModelTests: XCTestCase {

	private var viewModel: CityTableViewCellViewModelType!
	private var repository: FakeWeatherRepository!
	private var timer: FakeIntervalTimer!

	override func setUp() {
		super.setUp()
		repository = FakeWeatherRepository()
		timer = FakeIntervalTimer()
		viewModel = CityTableViewCellViewModel(city: .london, repository: repository, localizer: FakeLocalizer())
	}

	override func tearDown() {
		super.tearDown()
		viewModel = nil
		timer = nil
		repository = nil
	}

	func test_WhenInit_ThenStateIsLoading() {
		viewModel.outputs.state.assertWillBeEqual(to: .loading)
	}

	func test_GivenError_ThenStateIsFailure() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.state.expectEqual(to: .failure, with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenSuccess_ThenStateIsComplete() {
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.state.expectEqual(to: .complete(WeatherResponse.fake()), with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenSuccess_ThenGradientSet() {
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.gradient.expectEqual(to: .sunny, with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenSuccess_ThenTempSet() {
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.temp.expectEqual(to: "1.0c", with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenSuccess_ThenIconSet() {
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.icon.expectEqual(to: UIImage(systemName: "sun.max"), with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenError_ThenGradientSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.gradient.expectEqual(to: .cloud, with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenError_ThenTempSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.temp.expectEqual(to: "-", with: expectation)
		waitForExpectations(timeout: 1)
	}

	func test_GivenError_ThenIconSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		viewModel.inputs.fetchWeather()
		let expectation = self.expectation(description: "test")
		viewModel.outputs.icon.expectEqual(to: nil, with: expectation)
		waitForExpectations(timeout: 1)
	}
}

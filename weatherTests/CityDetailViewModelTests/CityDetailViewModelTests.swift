import XCTest
@testable import weather

final class CityDetailViewModelTests: XCTestCase {

	private var viewModel: CityDetailViewModelType!
	private var repository: FakeWeatherRepository!
	private var timer: FakeIntervalTimer!

	override func setUp() {
		super.setUp()
		repository = FakeWeatherRepository()
		timer = FakeIntervalTimer()
		viewModel = CityDetailViewModel(city: .london,
										repository: repository,
										weather: .fake(),
										timer: timer,
										localizer: FakeLocalizer())
	}

	override func tearDown() {
		super.tearDown()
		viewModel = nil
		timer = nil
		repository = nil
	}

	func test_Init_GradientSet() {
		viewModel.outputs.gradient.assertWillBeEqual(to: .cityDetailBG)
	}

	func test_Init_CityNameSet() {
		viewModel.outputs.cityName.assertWillBeEqual(to: "london")
	}

	func test_InitWithWeather_ThenWeatherIsSet() {
		viewModel.outputs.temp.assertWillBeEqual(to: "1.0c")
	}

	func test_InitWithoutWeather_ThenWeatherIsLoading() {
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.temp.assertWillBeEqual(to: "-")
	}

	func test_When_Init_TimerStarts() {
		XCTAssertEqual(timer.startCalledCount, 1)
	}

	func test_WhenViewDissapears_TimerStopped() {
		viewModel.inputs.viewDidDissappear()
		XCTAssertEqual(timer.stopCalledCount, 1)
	}

	func test_OnTimer_GivenSuccess_TempSet() {
		let expectation = self.expectation(description: "test")
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.temp.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.temp.expectEqual(to: "1.0c", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenSuccess_IconSet() {
		let expectation = self.expectation(description: "test")
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.icon.assertWillBeEqual(to: nil)
		timer.testPublisher.send(Void())
		viewModel.outputs.icon.expectEqual(to: UIImage(systemName: "sun.max"), with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenSuccess_descriptionSet() {
		let expectation = self.expectation(description: "test")
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.weatherDescription.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.weatherDescription.expectEqual(to: "test", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenSuccess_feelsLikeSet() {
		let expectation = self.expectation(description: "test")
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.feelLike.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.feelLike.expectEqual(to: "weather.details.feels.like 1.0", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenSuccess_highLowSet() {
		let expectation = self.expectation(description: "test")
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.highLow.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.highLow.expectEqual(to: "weather.details.high.low 1.0 1.0", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenError_TempSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		let expectation = self.expectation(description: "test")
		expectation.isInverted = true
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.temp.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.temp.expectEqual(to: "1.0c", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenError_IconSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		let expectation = self.expectation(description: "test")
		expectation.isInverted = true
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.icon.assertWillBeEqual(to: nil)
		timer.testPublisher.send(Void())
		viewModel.outputs.icon.expectEqual(to: UIImage(systemName: "sun.max"), with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenError_descriptionSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		let expectation = self.expectation(description: "test")
		expectation.isInverted = true
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.weatherDescription.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.weatherDescription.expectEqual(to: "test", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenError_feelsLikeSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		let expectation = self.expectation(description: "test")
		expectation.isInverted = true
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.feelLike.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.feelLike.expectEqual(to: "weather.details.feels.like 1.0", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

	func test_OnTimer_GivenError_highLowSet() {
		repository.getWeatherError = NSError(domain: "test", code: -1, userInfo: [:])
		let expectation = self.expectation(description: "test")
		expectation.isInverted = true
		viewModel = CityDetailViewModel(city: .london, repository: repository, weather: nil, localizer: FakeLocalizer())
		viewModel.outputs.highLow.assertWillBeEqual(to: "-")
		timer.testPublisher.send(Void())
		viewModel.outputs.highLow.expectEqual(to: "weather.details.high.low 1.0 1.0", with: expectation)
		waitForExpectations(timeout: 0.01)
	}

}

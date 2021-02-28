import XCTest
@testable import weather

final class CitySelectionViewModelTests: XCTestCase {

	private var viewModel: CitySelectionViewModelType!
	private var repository: WeatherRepositoryType!
	private var timer: FakeIntervalTimer!
	private var delegateMock: CitySelectionViewModelDelegate!

	override func setUp() {
		super.setUp()
		repository = FakeWeatherRepository()
		timer = FakeIntervalTimer()
		viewModel = CitySelectionViewModel(repository: repository,
										   timer: timer,
										   localizer: FakeLocalizer())
		delegateMock = MockCitySelectionViewModelDelegate()
		viewModel.delegate = delegateMock
	}

	override func tearDown() {
		super.tearDown()
		viewModel = nil
		timer = nil
		repository = nil
		delegateMock = nil
	}

	func test_WhenInit_ThenDataSourceSet() {
		viewModel.outputs.dataSource.assertWillNotBeNil()
	}

	func test_WhenInit_TitleSet() {
		viewModel.outputs.title.assertWillBeEqual(to: "city.selection.title")
	}

	func test_WhenInit_GradientSet() {
		viewModel.outputs.gradient.assertWillBeEqual(to: Gradient.citySelectorBG)
	}

	func test_WhenViewAppears_TimerStarted() {
		viewModel.inputs.viewDidAppear()
		XCTAssertEqual(timer.startCalledCount, 1)
	}

	func test_WhenViewDisappears_TimerStopped() {
		viewModel.inputs.viewDidDisappear()
		XCTAssertEqual(timer.stopCalledCount, 1)
	}
}

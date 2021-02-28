import Combine
import Foundation
@testable import weather

final class FakeIntervalTimer: IntervalTimerType {

	let testPublisher = PassthroughSubject<Void, Never>()

	var startCalledCount = 0
	func start() {
		startCalledCount += 1
	}
	var stopCalledCount = 0
	func stop() {
		stopCalledCount += 1
	}

	var publisher: AnyPublisher<Void, Never> {
		return testPublisher.eraseToAnyPublisher()
	}
}

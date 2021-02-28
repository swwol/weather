import Combine
import Foundation

protocol IntervalTimerType {
	func start()
	func stop()
	var publisher: AnyPublisher<Void, Never> { get }
}

final class IntervalTimer: IntervalTimerType {
	 var cancellables = Set<AnyCancellable>()
	 private let interval: TimeInterval
	 private let timerPublisher = PassthroughSubject<Void, Never>()

	var publisher: AnyPublisher<Void, Never> {
		timerPublisher.eraseToAnyPublisher()
	}

	init(interval: TimeInterval) {
		self.interval = interval
	}
	func start() {
		cancellables.forEach { $0.cancel() }
		let timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
		timer.sink { [weak self] _ in
			self?.timerPublisher.send(Void())
		}
		.store(in: &cancellables)
	}

	func stop() {
		cancellables.forEach { $0.cancel() }
	}
}

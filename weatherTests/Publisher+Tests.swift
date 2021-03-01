import Combine
@testable import weather
import XCTest

extension Publisher {
	func mockedSubscriber() -> MockSubscriber<Output, Failure> {
		let mockedSubscriber = MockSubscriber<Output, Failure>()
		subscribe(mockedSubscriber)
		return mockedSubscriber
	}

	func assertWillBeEqual(
		to expected: Output,
		message: String = "",
		file: StaticString = #filePath,
		line: UInt = #line
	) where Output: Equatable {
		subscribe(TestSubscriber<Output, Failure>(expected: expected, message, file, line))
	}

	func expectEqual(
		to expected: Output,
		with expectation: XCTestExpectation
	) where Output: Equatable {
		subscribe(Subscribers.Sink(
					receiveCompletion: { _ in },
					receiveValue: {
						if expected == $0 {
							expectation.fulfill()
						}
					})
		)
	}

	func assertWillNotBeNil(
		message: String = "",
		file: StaticString = #filePath,
		line: UInt = #line
	) {
		subscribe(Subscribers.Sink<Output, Failure> { value in
			XCTAssertNotNil(value, message, file: file, line: line)
		})
	}
}

final class MockSubscriber<Input, Failure: Error>: Subscriber {
	private(set) var spyValues = [Input]()

	func receive(subscription: Subscription) {
		subscription.request(.unlimited)
	}

	func receive(_ input: Input) -> Subscribers.Demand {
		spyValues.append(input)
		return .none
	}

	func receive(completion: Subscribers.Completion<Failure>) { }
}

private final class TestSubscriber<Input: Equatable, Failure: Error>: Subscriber {
	private let expected: Input
	private let message: String
	private let file: StaticString
	private let line: UInt

	init(expected: Input, _ message: String, _ file: StaticString, _ line: UInt) {
		self.expected = expected
		self.message = message
		self.file = file
		self.line = line
	}
	func receive(subscription: Subscription) {
		subscription.request(.max(1))
	}
	func receive(_ input: Input) -> Subscribers.Demand {
		XCTAssertEqual(input, expected, message, file: file, line: line)
		return .none
	}
	func receive(completion: Subscribers.Completion<Failure>) {}
}

extension Subscribers.Sink {
	convenience init(_ receiveValue: @escaping (Input) -> Void) {
		self.init(receiveCompletion: { _ in }, receiveValue: receiveValue)
	}
}

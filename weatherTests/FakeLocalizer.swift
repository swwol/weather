@testable import weather
import XCTest

struct FakeLocalizer: StringLocalizing {
	func localize(_ key: String) -> String {
		return key
	}

	func localize(_ key: String, _ values: String...) -> String {
		return String(format: localize(key),
					  arguments: values)
	}

	func localize(_ key: String, _ values: [String]) -> String {
		return String(format: localize(key),
					  arguments: values)
	}
}

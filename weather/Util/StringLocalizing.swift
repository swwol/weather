import Foundation

protocol StringLocalizing {
	func localize(_ key: String) -> String
	func localize(_ key: String, _ values: String... ) -> String
	func localize(_ key: String, _ values: [String]) -> String
}

struct Localizer: StringLocalizing {
	private let bundle: Bundle?
	init(bundle: Bundle? = nil) {
		self.bundle = bundle
	}

	func localize(_ key: String) -> String {
		return NSLocalizedString(key,
								 tableName: nil,
								 bundle: bundle ?? Bundle.main,
								 value: "** \(key) **",
								 comment: "")
	}

	func localize(_ key: String, _ values: String...) -> String {
		return String(format: localize(key), arguments: values)
	}

	func localize(_ key: String, _ values: [String]) -> String {
		return String(format: localize(key), arguments: values)
	}
}

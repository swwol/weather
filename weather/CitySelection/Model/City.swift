import Foundation

enum City: String, CaseIterable {
	case london
	case tokyo
	case newYork
	case berlin
	case paris

	var localizedKey: String {
		rawValue
	}
}

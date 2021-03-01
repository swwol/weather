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

	var identifier: String {
		switch self {
		case .london:
			return "2643743"
		case .tokyo:
			return "1850147"
		case .newYork:
			return "5128638"
		case .berlin:
			return "2950158"
		case .paris:
			return "2988506"
		}
	}
}

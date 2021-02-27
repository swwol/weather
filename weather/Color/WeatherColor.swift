import UIKit

enum WeatherColor: String {
	case mainGradLight
	case mainGradDark

	var uiColor: UIColor {
		 UIColor(named: rawValue)!
	}

	var cgColor: CGColor {
		 uiColor.cgColor
	}
}


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

enum Gradient {
	case citySelectorBG

	var configuration: GradientConfiguration {
		switch self {
		case .citySelectorBG:
			return (colors: [WeatherColor.mainGradDark.cgColor, WeatherColor.mainGradLight.cgColor],
					direction: GradientOrientation.vertical.direction)
		}
	}
}


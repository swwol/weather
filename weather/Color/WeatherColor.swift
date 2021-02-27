import UIKit

enum WeatherColor: String {
	case mainGradLight
	case mainGradDark
	case sunnyLight
	case sunnyDark

	var uiColor: UIColor {
		 UIColor(named: rawValue)!
	}

	var cgColor: CGColor {
		 uiColor.cgColor
	}
}

enum Gradient {
	case citySelectorBG
	case sunny

	var configuration: GradientConfiguration {
		switch self {
		case .citySelectorBG:
			return (colors: [WeatherColor.mainGradDark.cgColor, WeatherColor.mainGradLight.cgColor],
					direction: GradientOrientation.vertical.direction)
		case .sunny:
			return (colors: [WeatherColor.sunnyLight.cgColor, WeatherColor.sunnyDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		}
	}
}


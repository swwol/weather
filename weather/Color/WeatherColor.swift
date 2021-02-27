import UIKit

enum WeatherColor: String {
	case mainGradLight
	case mainGradDark
	case detailGradLight
	case detailGradDark
	case sunnyLight
	case sunnyDark
	case cloudLight
	case cloudDark
	case rainLight
	case rainDark
	case snowLight
	case snowDark
	case thunderLight
	case thunderDark

	var uiColor: UIColor {
		 UIColor(named: rawValue)!
	}

	var cgColor: CGColor {
		 uiColor.cgColor
	}
}

enum Gradient {
	case citySelectorBG
	case cityDetailBG
	case sunny
	case rain
	case thunder
	case snow
	case cloud

	var configuration: GradientConfiguration {
		switch self {
		case .citySelectorBG:
			return (colors: [WeatherColor.mainGradDark.cgColor, WeatherColor.mainGradLight.cgColor],
					direction: GradientOrientation.vertical.direction)
		case .cityDetailBG:
			return (colors: [WeatherColor.detailGradDark.cgColor, WeatherColor.detailGradLight.cgColor],
					direction: GradientOrientation.vertical.direction)
		case .sunny:
			return (colors: [WeatherColor.sunnyLight.cgColor, WeatherColor.sunnyDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		case .rain:
			return (colors: [WeatherColor.rainLight.cgColor, WeatherColor.rainDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		case .thunder:
			return (colors: [WeatherColor.thunderLight.cgColor, WeatherColor.thunderDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		case .snow:
			return (colors: [WeatherColor.snowLight.cgColor, WeatherColor.snowDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		case .cloud:
			return (colors: [WeatherColor.cloudLight.cgColor, WeatherColor.cloudDark.cgColor],
					direction: GradientOrientation.horizontal.direction)
		}
	}
}


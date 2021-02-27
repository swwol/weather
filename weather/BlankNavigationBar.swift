import UIKit

final class BlankNavigationBar: UINavigationBar {
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		commonInit()
	}

	private func commonInit() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithTransparentBackground()
		appearance.shadowColor = .clear
		appearance.backgroundColor = .clear
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white,
										  .font: UIFont(name: "Lato-Regular", size: 18)!]
		compactAppearance = appearance
		standardAppearance = appearance
		scrollEdgeAppearance = appearance
		backgroundColor = appearance.backgroundColor
	}
}

final class LightStatusBarNavigationController: UINavigationController {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

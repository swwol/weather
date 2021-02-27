import UIKit

class GradientView: UIView {

	func setGradient(colors: [CGColor]) {
			guard let gradientLayer = self.layer as? CAGradientLayer else { return }
			gradientLayer.colors = colors
		}

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
}

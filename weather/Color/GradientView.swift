import Combine
import UIKit

typealias GradientPoints = (start: CGPoint, end: CGPoint)
typealias GradientConfiguration = (colors: [CGColor], direction: GradientPoints)

enum GradientOrientation {
	case horizontal
	case vertical

	var direction: GradientPoints {
		switch self {
		case .vertical:
			return (start: .zero, end: CGPoint(x: 0, y: 1))
		case .horizontal:
			return (start: .zero, end: CGPoint(x: 1, y: 0))
		}
	}
}

class GradientView: UIView {
	func setGradient(configuration: GradientConfiguration) {
		guard let gradientLayer = self.layer as? CAGradientLayer else { return }
		gradientLayer.colors = configuration.colors
		gradientLayer.startPoint = configuration.direction.start
		gradientLayer.endPoint = configuration.direction.end
	}

	override class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
}

extension Publisher where Output == Gradient, Failure == Never {
	func set<Root: GradientView>(on view: Root) -> AnyCancellable {
		return sink {
			view.setGradient(configuration: $0.configuration)
		}
	}
}

import UIKit

extension UIDevice {
	var scaleFactor: CGFloat {
		return userInterfaceIdiom == .pad ? 1.5 : 1
	}
}

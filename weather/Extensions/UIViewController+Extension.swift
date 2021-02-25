import UIKit

extension UIViewController {
	static func fromStoryboard<T: UIViewController>() -> T {
		let bundle = Bundle(for: self)
		let name = String(describing: self).replacingOccurrences(of: "ViewController", with: "")
		let storyboard = UIStoryboard(name: name, bundle: bundle)

		guard let viewController = storyboard.instantiateInitialViewController() as? T else {
			let error = """
			Storyboard for \(self) can't be instantiated.
			Make sure to set an initial viewcontroller in the Storyboard and assign the correct custom class.
			"""
			fatalError(error)
		}
		return viewController
	}
}

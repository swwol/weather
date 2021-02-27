import Combine
import UIKit

final class CityDetailViewController: UIViewController {

	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet private weak var temp: UILabel!
	@IBOutlet private weak var city: UILabel!
	@IBOutlet private weak var mainWeather: UILabel!
	@IBOutlet private weak var feels: UILabel!
	@IBOutlet private weak var highLow: UILabel!
	@IBOutlet private weak var stack: UIStackView!

	var viewModel: CityDetailViewModelType!
	private var cancellables = Set<AnyCancellable>()

	var gradientView: GradientView {
		self.view as! GradientView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bind(viewModel.outputs)
	}

	private func bind(_ outputs: CityDetailViewModelOutputsType) {
		outputs
			.gradient
			.set(on: gradientView)
			.store(in: &cancellables)
	}
}


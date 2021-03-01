import Combine
import UIKit

final class CityDetailViewController: UIViewController {

	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet private weak var temp: UILabel!
	@IBOutlet private weak var city: UILabel!
	@IBOutlet private weak var weatherDescription: UILabel!
	@IBOutlet private weak var feels: UILabel!
	@IBOutlet private weak var highLow: UILabel!
	@IBOutlet private weak var stack: UIStackView!
	@IBOutlet private weak var borderView: UIView!
	@IBOutlet private weak var labelBG: UIView!
	@IBOutlet private weak var iconWidthConstraint: NSLayoutConstraint!
	@IBOutlet private weak var labelBGWidthContraint: NSLayoutConstraint!
	@IBOutlet private weak var borderHeightConstraint: NSLayoutConstraint!
	@IBOutlet private weak var borderWidthConstraint: NSLayoutConstraint!
	var viewModel: CityDetailViewModelType!
	private var cancellables = Set<AnyCancellable>()

	var gradientView: GradientView {
		self.view as! GradientView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		stack.spacing = 20 * UIDevice.current.scaleFactor
		stack.setCustomSpacing(2 * UIDevice.current.scaleFactor, after: city)
		stack.setCustomSpacing(33 * UIDevice.current.scaleFactor, after: feels)
		borderView.backgroundColor = .clear
		borderView.layer.cornerRadius = 7
		borderView.layer.borderWidth = 2
		borderView.layer.borderColor = UIColor.white.cgColor
		icon.tintColor = .white
		labelBG.backgroundColor = WeatherColor.labelBG.uiColor
		labelBG.layer.cornerRadius = 15
		view.sendSubviewToBack(labelBG)

		[temp, city, weatherDescription, feels, highLow].forEach {
			$0.font = $0.font.withSize($0.font.pointSize * UIDevice.current.scaleFactor)
		}

		iconWidthConstraint.constant = 40 * UIDevice.current.scaleFactor
		labelBGWidthContraint.constant = 30 * UIDevice.current.scaleFactor
		borderHeightConstraint.constant = 46 * UIDevice.current.scaleFactor
		borderWidthConstraint.constant = 26 * UIDevice.current.scaleFactor

		bind(viewModel.outputs)
	}

	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		viewModel.inputs.viewDidDissappear()
	}

	private func bind(_ outputs: CityDetailViewModelOutputsType) {
		outputs
			.gradient
			.set(on: gradientView)
			.store(in: &cancellables)
		outputs
			.icon
			.assign(to: \.image, on: icon)
			.store(in: &cancellables)
		outputs
			.temp
			.assign(to: \.text, on: temp)
			.store(in: &cancellables)
		outputs
			.cityName
			.assign(to: \.text, on: city)
			.store(in: &cancellables)
		outputs
			.weatherDescription
			.assign(to: \.text, on: weatherDescription)
			.store(in: &cancellables)
		outputs
			.feelLike
			.assign(to: \.text, on: feels)
			.store(in: &cancellables)
		outputs
			.highLow
			.assign(to: \.text, on: highLow)
			.store(in: &cancellables)
	}
}

import Combine
import UIKit

final class CityTableViewCell: UITableViewCell {
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet private weak var tempLabel: UILabel!
	@IBOutlet private weak var gradientView: GradientView!

	private var cancellables = Set<AnyCancellable>()

	var viewModel: CityTableViewCellViewModelType! {
		didSet {
			bind(viewModel.outputs)
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 7
		clipsToBounds = true
		icon.tintColor = .white
	}

	private func bind(_ outputs: CityTableViewCellViewModelOutputsType) {
		outputs
			.cityName
			.assign(to: \.text, on: cityLabel)
			.store(in: &cancellables)
		outputs
			.temp
			.assign(to: \.text, on: tempLabel)
			.store(in: &cancellables)
		outputs
			.gradient
			.set(on: gradientView)
			.store(in: &cancellables)
		outputs
			.icon
			.assign(to: \.image, on: icon)
			.store(in: &cancellables)
	}

	override func prepareForReuse() {
		super.prepareForReuse()
		cancellables.forEach { $0.cancel() }
		cancellables.removeAll()
	}
}

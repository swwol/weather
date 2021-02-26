import Combine
import UIKit

final class CityTableViewCell: UITableViewCell {
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet private weak var tempLabel: UILabel!

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
	}

	private func bind(_ outputs: CityTableViewCellViewModelOutputsType) {
		outputs
			.cityLabel
			.assign(to: \.text, on: cityLabel)
			.store(in: &cancellables)

	}
}

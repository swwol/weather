import Combine
import UIKit

final class CitySelectionViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!

	var viewModel: CitySelectionViewModelType!
	private var cancellables = Set<AnyCancellable>()

	var gradientView: GradientView {
		self.view as! GradientView
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.backgroundColor = .clear
		tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
		bind(viewModel.outputs)
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.inputs.viewDidAppear()
	}

	private func bind(_ outputs: CitySelectionViewModelOutputsType) {
		outputs
			.dataSource
			.sink { [weak self] dataSource in
				self?.tableView.dataSource = dataSource
				self?.tableView.delegate = dataSource
			//	dataSource.tableView = self?.tableView
			}
			.store(in: &cancellables)

		outputs
			.title
			.assign(to: \.title, on: self)
			.store(in: &cancellables)

		outputs
			.gradient
			.set(on: gradientView)
			.store(in: &cancellables)
	}
}


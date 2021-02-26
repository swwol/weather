import Combine
import UIKit

final class CitySelectionViewController: UIViewController {

	@IBOutlet private weak var tableView: UITableView!

	var viewModel: CitySelectionViewModelType!
	private var cancellables = Set<AnyCancellable>()

	override func viewDidLoad() {
		super.viewDidLoad()
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
	}
}

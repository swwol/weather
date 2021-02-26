import Combine
import UIKit

protocol CitySelectionViewModelInputsType {
	func viewDidAppear()
}

protocol CitySelectionViewModelOutputsType {
	var dataSource: AnyPublisher<CityDataSource, Never> { get }
}

protocol CitySelectionViewModelType {
	var inputs: CitySelectionViewModelInputsType { get }
	var outputs: CitySelectionViewModelOutputsType { get }
}

final class CitySelectionViewModel: CitySelectionViewModelType, CitySelectionViewModelInputsType, CitySelectionViewModelOutputsType {

	var inputs: CitySelectionViewModelInputsType { return self }
	var outputs: CitySelectionViewModelOutputsType { return self }
	let dataSource: AnyPublisher<CityDataSource, Never>

	init() {
		dataSource = Just(CityDataSource()).eraseToAnyPublisher()
	}

	func viewDidAppear() {
	}
}


final class CityDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		City.allCases.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier) as? CityTableViewCell else {
			fatalError("unable to dequeue CityTableViewCell")
		}
		cell.cityLabel.text = "bladf"
		return cell
	}
}


final class CityTableViewCell: UITableViewCell {
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet weak var cityLabel: UILabel!
	@IBOutlet private weak var tempLabel: UILabel!
}

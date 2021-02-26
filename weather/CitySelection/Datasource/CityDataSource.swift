import UIKit

final class CityDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

	enum Constants {
		static let cellSpacing: CGFloat = 10
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		City.allCases.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		1
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		Constants.cellSpacing
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let separator = UIView()
		separator.backgroundColor = .clear
		return separator
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.reuseIdentifier) as? CityTableViewCell else {
			fatalError("unable to dequeue CityTableViewCell")
		}
		cell.viewModel = CityTableViewCellViewModel(city: City.allCases[indexPath.section])
		return cell
	}
}

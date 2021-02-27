import UIKit

protocol CityDataSourceDelegate: AnyObject {
	func didSelect(city: City, on dataSource: CityDataSource)
}

final class CityDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

	private let repository: WeatherRepositoryType
	weak var delegate: CityDataSourceDelegate?

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}

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
		cell.viewModel = CityTableViewCellViewModel(city: City.allCases[indexPath.section], repository: repository)
		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let cell = cell as? CityTableViewCell else { return }
		cell.viewModel.inputs.fetchWeather()
	}

	func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		let selectedCity = City.allCases[indexPath.section]
		delegate?.didSelect(city: selectedCity, on: self)
	}
}

import Combine
import UIKit

protocol CityDataSourceDelegate: AnyObject {
	func didSelect(city: City, weather: WeatherResponse?, on dataSource: CityDataSource)
}

final class CityDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

	private let repository: WeatherRepositoryType
	weak var delegate: CityDataSourceDelegate?
	var viewModels: [City: CityTableViewCellViewModelType] = [:]
	var cancellable: AnyCancellable?

	init(repository: WeatherRepositoryType) {
		self.repository = repository
	}

	enum Constants {
		static let cellSpacing: CGFloat = 10 * UIDevice.current.scaleFactor
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
		let city = City.allCases[indexPath.section]
		let viewModel = CityTableViewCellViewModel(city: city, repository: repository)
		viewModels[city] = viewModel
		cell.viewModel = viewModel
		return cell
	}

	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		guard let cell = cell as? CityTableViewCell else { return }
		cell.viewModel.inputs.fetchWeather()
	}

	func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let city = City.allCases[indexPath.section]
		viewModels[city] = nil
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let city = City.allCases[indexPath.section]
		guard let viewModel = viewModels[city] else { return }
		self.delegate?.didSelect(city: city, weather: viewModel.outputs.currentWeather, on: self)
	}
	
	func updateVisibleCells() {
		viewModels.values.forEach { viewModel in
			viewModel.inputs.fetchWeather()
		}
	}
}

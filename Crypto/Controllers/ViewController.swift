import NVActivityIndicatorView
import UIKit

final class ViewController: UIViewController {

    var model = [CustomCryptoModel]()

    private var searchController = UISearchController()

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .white, padding: 0)

    private var currencyFilterArray: [CustomCryptoModel] = []

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        getApi()
        configurationNavigationBar()
        appearanceTableConfiguration()
        behaviorTableConfiguration()
        configurationSearchController()

        // Add subview
        view.addSubview(tableView)
    }

    // MARK: - viewDidLayoutSubviews

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }

    private func getApi() {
        startAnimationIndicator()
        NetworkManager.networkManager.getAPI { [weak self] apiData in
            self?.model = apiData

            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }

            self?.stopAnimationIndocator()
        }
    }

    private func configurationNavigationBar() {
        title = "Exchanges Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func appearanceTableConfiguration() {
        tableView.backgroundColor = UIColor(named: "CustomColor")
    }

    private func behaviorTableConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cell)
    }

    private func startAnimationIndicator() {
        tableView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y - 100)
            make.width.height.equalTo(50)
        }
        activityIndicator.startAnimating()
    }

    private func stopAnimationIndocator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }

    private func configurationSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search currency..."
        searchController.searchBar.barTintColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return currencyFilterArray.count
        } else {
            return model.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cell, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let currency = (searchController.isActive) ? currencyFilterArray[indexPath.row] : model[indexPath.row]
        cell.setLabel(name: currency.name ?? "None", course: String(format: "%.3f", currency.priceUsd ?? "0"))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = InfoCryptoViewController()
        navigationController?.pushViewController(vc, animated: true)
        let currency = (searchController.isActive) ? currencyFilterArray[indexPath.row] : model[indexPath.row]
        vc.name = currency.name ?? "none"
        vc.course = String(format: "%.3f", currency.priceUsd ?? "0")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension ViewController: UISearchResultsUpdating {
    private func searchCurrencyFilterArray(for searchText: String) {
        currencyFilterArray = model.filter { coins -> Bool in
            if let name = coins.assetId?.lowercased() {
                return name.hasPrefix(searchText.lowercased())
            }
            return false
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            searchCurrencyFilterArray(for: searchText)
            tableView.reloadData()
        }
    }
}

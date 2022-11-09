import Alamofire
import UIKit

protocol CryptoTracker: AnyObject {
    func setActivityIndicator(activated: Bool)
    func reloadData()
}

final class DefaultCryptoTrackerView: UIViewController {

    // MARK: - Properties

    var presenter: CryptoTrackerPresenter?

    // MARK: Public

    // MARK: Private

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    private var isRequestInProgress = false {
        didSet {
            if isRequestInProgress {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter?.requestCurrencies()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configurationNavigationBar()
        appearanceTableConfiguration()
        behaviorTableConfiguration()

        // Add subview

        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
        configurationActivityIndicator()
    }

    // MARK: - API

    // MARK: - Setups

    private func configurationNavigationBar() {
        title = "Exchanges Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func appearanceTableConfiguration() {
        tableView.backgroundColor = CustomColor.customColor
    }

    private func behaviorTableConfiguration() {
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cell)
    }

    private func configurationActivityIndicator() {

        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.center.x)
            make.centerY.equalTo(view.center.y)
            make.width.height.equalTo(50)
        }
    }

    // MARK: - Helpers
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DefaultCryptoTrackerView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        presenter?.currenciesArray.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cell, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        let data = presenter?.currenciesArray[safe: indexPath.row]
        cell.setLabel(name: data?.name ?? "none", course: data?.priceInUsd)
        cell.cellDidTappedHandler = { self.presenter?.currencyCellDidTapped(id: data?.id ?? "") }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}

extension DefaultCryptoTrackerView: CryptoTracker {
    func setActivityIndicator(activated: Bool) {
        isRequestInProgress = activated
    }

    func reloadData() {
        tableView.reloadData()
    }
}

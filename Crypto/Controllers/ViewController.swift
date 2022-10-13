import NVActivityIndicatorView
import UIKit

final class ViewController: UIViewController {

    private var model = [CryptoModel]()

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    private let activityIndicator = NVActivityIndicatorView(frame: .zero, type: .ballClipRotateMultiple, color: .white, padding: 0)

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        getApi()
        configurationNavigationBar()
        appearanceTableConfiguration()
        behaviorTableConfiguration()

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
        NetworkManager.networkManager.getAPI { apiData in
            self.model = apiData

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

            self.stopAnimationIndocator()
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.cell, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }

        cell.setLabel(name: model[indexPath.row].name, course: String(model[indexPath.row].volume_1mth_usd))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = InfoCryptoViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.name = model[indexPath.row].name
        vc.course = String(model[indexPath.row].volume_1mth_usd)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

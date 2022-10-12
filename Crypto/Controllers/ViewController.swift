import UIKit

final class ViewController: UIViewController {

    private var model = [CryptoModel]()

    let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        getapi()
        configurationNavigationBar()
        appearanceTableConfiguration()
        behaviorTableConfiguration()

        // Add subview
        view.addSubview(tableView)
    }

    private func getapi() {
        NetworkManager.networkManager.getAPI { apiData in
            self.model = apiData

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    private func configurationNavigationBar() {
        title = "Exchanges Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func appearanceTableConfiguration() {
        tableView.backgroundColor = UIColor(named: "CustomColol")
    }

    private func behaviorTableConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.cell)
    }

    // MARK: - viewDidLayoutSubviews

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
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

        cell.setLabel(name: model[indexPath.row].asset_id, course: String(model[indexPath.row].volume_1mth_usd))

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = InfoCryptoViewController()
        navigationController?.pushViewController(vc, animated: true)
        vc.name = model[indexPath.row].asset_id
        vc.course = String( model[indexPath.row].volume_1mth_usd)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

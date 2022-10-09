//
//  ViewController.swift
//  Crypto
//
//  Created by Даниэл Лабецкий on 9.10.22.
//

import UIKit

final class ViewController: UIViewController {
    
    private var model = [CryptoModel]()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableConfiguration()
        getapi()
        
        tableView.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        tableView.backgroundColor = UIColor(named: "CustomColor")
        
        title = "Exchanges Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
        
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
    
    private func tableConfiguration() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
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
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.setLabel(name: model[indexPath.row].asset_id, course: String(model[indexPath.row].volume_1mth_usd))
        
        return cell
    }

}

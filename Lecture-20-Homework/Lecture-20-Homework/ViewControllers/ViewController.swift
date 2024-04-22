//
//  ViewController.swift
//  Lecture-20-Homework
//
//  Created by Barbare Tepnadze on 22.04.24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var countriesData: [Country] = []
    var networkService = NetworkService()
    
    // MARK: - Elements
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initSetUp()
        navigationItem.title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchCountries()
    }
    // MARK: -  Setup and Styling
    func initSetUp() {
        initTable()
        view.addSubview(tableView)
        styleTable()
    }
    
    func initTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.separatorStyle = .none
    }
    
    func styleTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
        ])
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
    
    // MARK: - Networking
    func fetchCountries() {
        let networkService = NetworkService()
        networkService.fetchCountries { [weak self] countries, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch news: \(error)")
                } else if let countries = countries {
                    self?.countriesData = countries
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Table Extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let country = countriesData[indexPath.row]
        cell.initCard(with: country)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = countriesData[indexPath.row]
        let detailsVC = DetailsVC()
        detailsVC.country = selectedCountry
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
#Preview {
    ViewController()
}

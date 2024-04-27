//
//  CountriesViewController.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import UIKit

class CountriesViewController: UIViewController {
    // MARK: - Properties
    let viewModel = CountriesViewModel()
    
    // MARK: - Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.showsScopeBar = false
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        initSetUp()
        viewModel.delegate = self
        viewModel.setUpViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if viewModel.isFirstTimeLoggedIn() {
            showFirstTimeLoginAlert()
            viewModel.setFirstTimeLoggedIn(false)
        }
    }
    
    // MARK: -  Setup and Styling
    func updateUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func initSetUp() {
        initTable()
        initSearchController()
        view.addSubview(tableView)
        styleTable()
    }
    
    func initTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.separatorStyle = .none
    }
    
    func initSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func styleTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        tableView.rowHeight = 70
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
    }
}

    // MARK: - CountriesViewModelDelegate
extension CountriesViewController: CountriesViewModelDelegate {
    func countriesFetched(_ countries: [Country]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func navigateToDetailsVC(selectedCountry: Country) {
        let detailsVC = CountryDetailsViewController(selectedCountry: selectedCountry)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showFirstTimeLoginAlert() {
        let alert = UIAlertController(title: "გამარჯობა", message: "ალერტს გიგდებ პირველად დალოგინებულო მომხმარებელო!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ოკი", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

    // MARK: - Table Extension
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let country = viewModel.filteredCountries[indexPath.row]
        cell.initCard(with: country)
        return cell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        tableView.reloadRows(at: [indexPath], with: .none)
        viewModel.didSelectRow(index: indexPath)
    }
}

    // MARK: - Search Controller Extension
extension CountriesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    func filterContentForSearchText(_ searchText: String) {
        viewModel.searchCountries(with: searchText)
    }
}

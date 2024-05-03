//
//  CatFactsListViewController.swift
//  Lecture-23-Homework
//
//  Created by Barbare Tepnadze on 03.05.24.
//

import UIKit

class CatFactsViewController: UIViewController, UITableViewDelegate {
    // MARK: - Elements
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var viewModel = CatFactsViewModel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        setupTableView()
        bindViewModel()
        viewModel.fetchCatFacts() // ესეც არ უნდა იყოს აქ?
    }
    
    // MARK: - Setup and Styling
    private func initUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Cat Facts"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CatFactCell.self, forCellReuseIdentifier: "CatFactCell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    // ეს როგორ წავიღო ბოლომდე :( მეტი ვერ ვფიქრობ როგორ შევამოკლო
    private func bindViewModel() {
        viewModel.updateUI = {
            self.tableView.reloadData()
        }
        viewModel.showError = { error in
            print(error)
        }
    }
}

// MARK: - TableView DataSource and Delegate Extension
extension CatFactsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.catFactsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatFactCell", for: indexPath) as? CatFactCell else {
            return UITableViewCell()
        }
        let catFact = viewModel.catFacts[indexPath.row]
        cell.initCard(with: catFact)
        return cell
    }
}

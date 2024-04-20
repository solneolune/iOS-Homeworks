//
//  ViewController.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 19.04.24.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var newsData: [News] = []
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
        navigationItem.title = "Panicka News"
        navigationController?.navigationBar.prefersLargeTitles = true
        fetchNews()
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
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.separatorStyle = .none
    }
    
    func styleTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    // MARK: - Networking
    func fetchNews() {
        let networkService = NetworkService()
        networkService.fetchNews { [weak self] newsItems, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Failed to fetch news: \(error)")
                } else if let newsItems = newsItems {
                    self?.newsData = newsItems
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - Table Extension
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        let newsItem = newsData[indexPath.row]
        cell.initCard(with: newsItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNews = newsData[indexPath.row]
        let newsVC = NewsVC()
        newsVC.newsItem = selectedNews
        navigationController?.pushViewController(newsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}

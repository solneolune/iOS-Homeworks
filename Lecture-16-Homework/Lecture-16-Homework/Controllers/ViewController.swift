//
//  ViewController.swift
//  Lecture-16-Homework
//
//  Created by Barbare Tepnadze on 12.04.24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - PROPERTIES
    
    var contactsPrefixes = Array(Set(contacts.compactMap({String($0.name.prefix(1))}))) // იუთუბის ტუტორიალში იყო ასე, კი მეშინია ამდენ ფრჩხილს რომ ვუყურებ მაგრამ მუშაობს
    var contactsDict: [[String]] = []
    
    
    
    // MARK: - ELEMENTS
    
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        
        navigationItem.title = "iOS"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    
    // MARK: - SETUP AND STYLING
    func initSetUp() {
        initTable()
        view.addSubview(tableView)
        styleTable()
    }
    
    func initTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        sectionTable()
    }
    
    func styleTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    
    // MARK: - OTHER FUNCTIONS
    
    func sectionTable() {
        contactsDict = Dictionary(grouping: contacts, by: { String($0.name.prefix(1)).uppercased() })
            .sorted(by: { $0.key < $1.key })
            .map { $0.value.map { $0.name } }
        contactsPrefixes = contactsDict.map { String($0.first?.first ?? Character("")) }
    }
}



    // MARK: - TableView EXTENSION

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        contactsPrefixes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsDict[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let contact = contactsDict[indexPath.section][indexPath.row]
        cell.textLabel?.text = contact.capitalized
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        contactsPrefixes[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactsPrefixes
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section < contactsDict.count, indexPath.row < contactsDict[indexPath.section].count else { return }
        let name = contactsDict[indexPath.section][indexPath.row]
        if let contact = contacts.first(where: { $0.name.uppercased() == name.uppercased() }) {
            let detailsVC = DetailsVC()
            detailsVC.data = contact
            navigationController?.pushViewController(detailsVC, animated: true)
        } else {
            print("404 ვერ მოიძებნა")
        }
    }
}


#Preview {
    ViewController()
}


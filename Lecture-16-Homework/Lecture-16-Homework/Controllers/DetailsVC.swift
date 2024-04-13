//
//  DetailsVC.swift
//  Lecture-16-Homework
//
//  Created by Barbare Tepnadze on 12.04.24.
//

import UIKit

class DetailsVC: UIViewController {
    
    // MARK: - PROPERTIES
    
    var data: Contact?
    
    
    
    // MARK: - ELEMENTS

    let contactIcon: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 10, width: 60, height: 60))
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let infoStackView: UIStackView = {
            let stack = UIStackView()
            return stack
        }()
    
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        initSetUp()
        initData()
    }
    

    
    // MARK: - INIT AND STYLE FUNCTIONS
    
    func initSetUp() {
        initStackView()
        styleImage()
        styleNameLabel()
        styleInfoStack()
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            contactIcon,
            nameLabel,
            infoStackView
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        createInfoTable()
    }
    
    func initData() {
        if let data = data {
            nameLabel.text = data.name.capitalized
            loadImage(from: data, for: contactIcon)
            updateInfoTable(with: data)
        } else {
            nameLabel.text = "404 not found"
        }
    }
    
    func styleImage() {
        contactIcon.contentMode = .scaleAspectFill
        contactIcon.clipsToBounds = true
        contactIcon.layer.cornerRadius = 30
    }
    
    func styleNameLabel() {
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    func styleInfoStack() {
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.alignment = .fill
    }
    
    func createInfoTable() {
        let rows = [("Gender", ""), ("Age", ""), ("Hobby", "")]
        for row in rows {
            let rowView = createRow(title: row.0, value: row.1)
            infoStackView.addArrangedSubview(rowView)
        }
    }
    
    func updateInfoTable(with contact: Contact) {
        let details: [(String, String)] = [
            ("Gender", contact.gender.rawValue),
            ("Age", "\(contact.age)"),
            ("Hobby", contact.hobby)
        ]
        for (i, detail) in details.enumerated() {
            if let rowStackView = infoStackView.arrangedSubviews[i] as? UIStackView,
               let valueLabel = rowStackView.arrangedSubviews.last as? UILabel {
                valueLabel.text = detail.1
            }
        }
    }

    func createRow(title: String, value: String) -> UIStackView {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .systemFont(ofSize: 16)
        valueLabel.textAlignment = .right
        
        let rowStackView = UIStackView(arrangedSubviews: [titleLabel, valueLabel])
        rowStackView.distribution = .equalSpacing
        
        return rowStackView
    }
    
    
    
    // MARK: - ACTION FUNCTIONS
    
    func loadImage(from contact: Contact, for imageView: UIImageView) {
        guard let contactImg = contact.icon else {
            return
        }
        if let image = UIImage(named: contactImg) {
            contactIcon.image = image
            return
        }
    }
}

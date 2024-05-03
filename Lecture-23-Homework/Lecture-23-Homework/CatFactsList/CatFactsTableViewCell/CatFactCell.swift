//
//  CatFactCell.swift
//  Lecture-23-Homework
//
//  Created by Barbare Tepnadze on 03.05.24.
//

import UIKit

class CatFactCell: UITableViewCell {
    
    // MARK: - Elements
    let catFact = UILabel()
    
    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup and Styling
    func setupUI() {
        styleCard()
        styleFact()
    }
    
    func styleCard() {
        contentView.backgroundColor = .systemBackground
    }
    
    func styleFact() {
        catFact.translatesAutoresizingMaskIntoConstraints = false
        catFact.textColor = .label
        catFact.numberOfLines = 0
        catFact.lineBreakMode = .byWordWrapping
        catFact.textAlignment = .left
        contentView.addSubview(catFact)
        
        NSLayoutConstraint.activate([
            catFact.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            catFact.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            catFact.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            catFact.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Action Functions
    func initCard(with fact: CatFact) {
        catFact.text = "😽 " + fact.fact
    }
    
}

//
//  CountryCell.swift
//  Lecture-20-Homework
//
//  Created by Barbare Tepnadze on 22.04.24.
//

import UIKit

class CountryCell: UITableViewCell {
    
    // MARK: - Elements
    let iconImg = UIImageView()
    let countryName = UILabel()
    
    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup and Styling
    func setupUI() {
        styleCard()
        styleImg()
        styleName()
        accessoryType = .disclosureIndicator
    }
    
    func styleCard() {
        contentView.layer.cornerRadius = 37
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    func styleImg() {
        iconImg.contentMode = .scaleAspectFill
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        iconImg.layer.cornerRadius = 3
        iconImg.clipsToBounds = true
        contentView.addSubview(iconImg)
        NSLayoutConstraint.activate([
            iconImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            iconImg.widthAnchor.constraint(equalToConstant: 30),
            iconImg.heightAnchor.constraint(equalToConstant: 20)
        ])
        contentView.layoutIfNeeded()
    }
    
    func styleName() {
        countryName.textColor = .black
        countryName.numberOfLines = 1
        countryName.lineBreakMode = .byTruncatingTail
        countryName.textAlignment = .right
        countryName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countryName)
        NSLayoutConstraint.activate([
            countryName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            countryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -34),
            countryName.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor, constant: 120),
        ])
    }
    
    // MARK: - Action Functions
    func initCard(with card: Country) {
        loadImage(from: card.flags.png)
        countryName.text = card.name.official
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.iconImg.image = image
            }
        }.resume()
    }
}

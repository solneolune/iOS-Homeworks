//
//  ComplainCell.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class ComplainCell: UICollectionViewCell {
    
    // MARK: - Elements
    let iconImg = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup and Styling
    func setupUI() {
        styleCard()
        styleIcon()
        styleTitle()
        styleDescription()
    }
    
    func styleCard() {
        contentView.backgroundColor = UIColor(rgb: 0x262A34)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true
    }
    
    func styleIcon() {
        iconImg.contentMode = .scaleAspectFit
        iconImg.clipsToBounds = true
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImg)
        NSLayoutConstraint.activate([
            iconImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImg.widthAnchor.constraint(equalToConstant: 40),
            iconImg.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func styleTitle() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImg.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
        ])
    }
    
    func styleDescription() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        descriptionLabel.textColor = UIColor(rgb: 0x5E6272)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: - Initialize Card
    func initCard(with card: ComplainCard) {
        iconImg.image = UIImage(named: card.icon.rawValue)
        titleLabel.text = card.title
        descriptionLabel.text = card.description
    }
}


//
//  IconCell.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class IconCell: UICollectionViewCell {
    
    // MARK: - Elements
    let iconImageView = UIImageView()
    
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderWidth = isSelected ? 2 : 0
            contentView.layer.borderColor = isSelected ? UIColor.yellow.cgColor : UIColor.clear.cgColor
            contentView.layer.cornerRadius = 20
        } // არ მუშაობს, დამეხმარეთ 🥹🆘
    }
    
    // MARK: - Setup and Styling
    func setupUI() {
        styleIcon()
    }
    
    func styleIcon() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Configuration
    func configure(with imageName: String) {
        iconImageView.image = UIImage(named: imageName)
    }
}


//
//  NewsCell.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 20.04.24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Elements
    let bannerImg = UIImageView()
    let timeLabel = UILabel()
    let titleLabel = UILabel()
    
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
        styleTime()
        styleTitle()
    }
    
    func styleCard() {
        contentView.layer.cornerRadius = 15
        contentView.clipsToBounds = true
    }
    
    func styleImg() {
        bannerImg.translatesAutoresizingMaskIntoConstraints = false
        bannerImg.contentMode = .scaleAspectFill
        bannerImg.clipsToBounds = true
        contentView.addSubview(bannerImg)
        NSLayoutConstraint.activate([
            bannerImg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImg.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            bannerImg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImg.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func styleTime() {
        timeLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        timeLabel.textColor = .white
        timeLabel.numberOfLines = 0
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -30)
        ])
    }
    
    func styleTitle() {
        timeLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    // MARK: - Action Functions
    func initCard(with card: News) {
        loadImage(from: card.photoUrl)
        timeLabel.text = card.time
        titleLabel.text = card.title
    }
    
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.bannerImg.image = image
            }
        }.resume()
    }
}

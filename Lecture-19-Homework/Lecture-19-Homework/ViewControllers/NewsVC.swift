//
//  NewsVC.swift
//  Lecture-19-Homework
//
//  Created by Barbare Tepnadze on 20.04.24.
//

import UIKit

class NewsVC: UIViewController {
    // MARK: - Properties
    var newsItem: News?
    
    // MARK: - Elements
    let newsImg = UIImageView()
    let timeLabel = UILabel()
    let titleLabel = UILabel()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Details"
        navigationController?.navigationBar.prefersLargeTitles = true
        initSetUp()
        initData()
    }
    
    // MARK: - Setup and Styling
    func initSetUp() {
        initStackView()
        styleTimeLabel()
        styleTitleLabel()
        styleImage()
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            newsImg,
            timeLabel,
            titleLabel
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
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newsImg.heightAnchor.constraint(lessThanOrEqualToConstant: 190)
        ])
    }
    
    func styleImage() {
        newsImg.contentMode = .scaleAspectFill
        newsImg.clipsToBounds = true
        newsImg.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleTimeLabel() {
        timeLabel.textColor = .black
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    func styleTitleLabel() {
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    }
    
    func initData() {
        if let data = newsItem {
            loadImage(from: data.photoUrl)
            timeLabel.text = data.time
            titleLabel.text = data.title
        } else {
            titleLabel.text = "404 not found"
        }
    }
    
    // MARK: - Action Functions
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.newsImg.image = image
                self?.newsImg.layer.masksToBounds = true
                self?.newsImg.layer.cornerRadius = 30
            }
        }.resume()
    }
}

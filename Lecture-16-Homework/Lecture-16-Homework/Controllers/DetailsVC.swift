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
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
           let label = UILabel()
           return label
       }()
    
    
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        initSetUp()
        initData()
    }
    

    
    // MARK: - INIT AND STYLE FUNCTIONS
    
    func initSetUp() {
        initStackView()
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
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
    }
    
    func initData() {
        if let data = data {
            titleLabel.text = data.name
        } else {
            titleLabel.text = "404 not found"
        }
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


// MARK: - Preview
#Preview {
    DetailsVC()
}


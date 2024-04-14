//
//  ViewController.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class ViewController: BaseVC {
    
    // MARK: - ELEMENTS
    let addNewCardButton = AppButton(title: "ახალი წუწუნ ბარათის დამატება", color: UIColor(rgb: 0x0075FF), width: 290)
    
    var cardsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        initSetUp()
        initNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionLayout()
    }

    // MARK: - Setup and Styling
    func initSetUp() {
        initCollection()
        styleCollection()
        styleAddNewButton()
    }
    
    func initCollection() {
        cardsCollection.dataSource = self
        cardsCollection.delegate = self
        view.addSubview(cardsCollection)
        NSLayoutConstraint.activate([
            cardsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cardsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cardsCollection.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            cardsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
        cardsCollection.register(ComplainCell.self, forCellWithReuseIdentifier: "ComplainCell")
    }
    
    func configureCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        let padding: CGFloat = 16
        let collectionViewWidth = cardsCollection.frame.width
        let itemWidth = (collectionViewWidth - 3 * padding) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 190)
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumInteritemSpacing = padding
        layout.minimumLineSpacing = padding
        cardsCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    func styleCollection() {
        cardsCollection.backgroundColor = .clear
    }
    
    func styleAddNewButton() {
        view.addSubview(addNewCardButton)
        NSLayoutConstraint.activate([
            addNewCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addNewCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNewCardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addNewCardButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Action Functions
    func initNavigation() {
        navigate(addNewCardButton)
    }
    
    func navigate(_ button: UIButton) {
        button.addAction(UIAction(title: "ახალი ქარდის დამატება", handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            let newCard = NewCardVC()
            newCard.delegate = self
            newCard.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(newCard, animated: true)
        }), for: .touchUpInside)
    }
}

    // MARK: - Extensions
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let complainCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComplainCell", for: indexPath) as! ComplainCell
        let card = complainCards[indexPath.item]
        complainCell.iconImg.image = UIImage(named: card.icon.rawValue)
        complainCell.titleLabel.text = card.title
        complainCell.descriptionLabel.text = card.description
        return complainCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return complainCards.count
    }
}

extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: NewCardVCDelegate {
    func didAddNewCard(_ card: ComplainCard) {
        complainCards.append(card)
        cardsCollection.reloadData()
    }
}

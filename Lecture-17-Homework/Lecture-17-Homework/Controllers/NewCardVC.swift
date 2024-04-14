//
//  NewCardVC.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

protocol NewCardVCDelegate: AnyObject {
    func didAddNewCard(_ card: ComplainCard)
}

class NewCardVC: BaseVC {
    
    // MARK: - Properties
    var selectedIcon: Icon?
    weak var delegate: NewCardVCDelegate?
    
    // MARK: - Elements
    let titleLabel = UILabel()
    let titleInput = UITextField()
    let descriptionLabel = UILabel()
    let descriptionInput = UITextField()
    let addButton = AppButton(title: "დამატება", color: UIColor(rgb: 0x009B10), width: 48)
    
    var iconsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        initCreation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionLayout()
    }
    
    // MARK: - Setup and Styling
    func initSetUp() {
        initStackView()
        initCollection()
        styleCollection()
        initLabels()
        initInputs()
        styleAddNewButton()
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            titleInput,
            descriptionLabel,
            descriptionInput,
            iconsCollection
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18
//        stackView.spacing = CGFloat(spacing)
        stackView.spacing = 25
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func initCollection() {
        iconsCollection.dataSource = self
        iconsCollection.delegate = self
        iconsCollection.register(IconCell.self, forCellWithReuseIdentifier: "IconCell")
        iconsCollection.allowsMultipleSelection = false
    }
    
    func configureCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        iconsCollection.setCollectionViewLayout(layout, animated: true)
    }
    
    func styleCollection() {
        iconsCollection.backgroundColor = .clear
    }
    
    func initLabels() {
        styleLabel(titleLabel, text: "სათაური")
        styleLabel(descriptionLabel, text: "აღწერა")
    }
    
    func initInputs() {
        styleInput(titleInput, placeholder: "მაგ: პანიკა, დახმარება მჭირდება")
        styleInput(descriptionInput, placeholder: "მაგ: ფიგმამ გამიჭედა და ვინმემ გამომიგზავნეთ")
    }
    
    func styleLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
    }
    
    func styleInput(_ input: UITextField, placeholder: String) {
        input.placeholder = placeholder
        input.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: UIColor(rgb: 0x636363),
            .font: UIFont.systemFont(ofSize: 12, weight: .medium)
        ])
        input.textColor = .white
        input.backgroundColor = .clear
        input.layer.borderColor = UIColor(rgb: 0x8D8D8D).cgColor
        input.layer.borderWidth = 1.0
        input.layer.cornerRadius = 9
        input.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleAddNewButton() {
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    // MARK: - Action Functions
    func initCreation() {
        createCard(addButton)
    }
    
    func createCard(_ button: UIButton) {
        button.addAction(UIAction(title: "ქარდის დამატება", handler: { [weak self] _ in
            guard let self = self,
                  let title = titleInput.text, !title.isEmpty,
                  let description = descriptionInput.text, !description.isEmpty,
                  let icon = selectedIcon else { return }
            let newCard =  ComplainCard(icon: icon, title: title, description: description)
            self.delegate?.didAddNewCard(newCard)
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
    }
    
}

extension NewCardVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Icon.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IconCell", for: indexPath) as! IconCell
        let icon = Icon.allCases[indexPath.item]
        cell.configure(with: icon.rawValue)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIcon = Icon.allCases[indexPath.item]
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
}

extension NewCardVC: UICollectionViewDelegate {
    
}

#Preview {
    NewCardVC()
}

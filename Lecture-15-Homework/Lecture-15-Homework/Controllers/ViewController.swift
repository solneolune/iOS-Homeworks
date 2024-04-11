//
//  ViewController.swift
//  Lecture-15-Homework
//
//  Created by Barbare Tepnadze on 10.04.24.
//

import UIKit

class ViewController: BaseVC {
    
    // MARK: - PROPERTIES
    
    var bgColor: UIColor?
    
    
    
    // MARK: - ELEMENTS
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "მიშა ცაგარელის ჰაბი"
        return label
    }()
    
    let appDescription: UILabel = {
       let label = UILabel()
        label.text = "მოცემულ აპლიკაციაში შეგიძლიათ გაიგოთ თქვენი ზოდიაქოს ყველაზე გამოკვეთილი უნარები და თვისებები."
        return label
    }()
    
    let inputLabel: UILabel = {
        let label = UILabel()
        label.text = "ზოდიაქოს სახელი"
        return label
    }()
    
    let zodiacInput: UITextField = {
        let textField = UITextField()
        // ფლეისჰოლდერის სოუსი: https://stackoverflow.com/questions/26076054/changing-placeholder-text-color-with-swift
        textField.attributedPlaceholder = NSAttributedString(string: "ქალწული", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textField
    }()
    
    let getDetailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("შემდეგ", for: .normal)
        return button
    }()

    
    
    // MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true // ხახახახა
        
        initSetUp()
        initNavigation()
    }
    
    
    
    // MARK: - SETUP AND STYLING FUNCTIONS
    
    func initSetUp() {
        initBackgroundColor()
        initStackView()
        styleTitle()
        styleDescription()
        styleLabel()
        styleTextField()
        styleButton()
    }
    
    func initBackgroundColor() {
        if bgColor != nil {
            view.backgroundColor = bgColor
        } else {
            view.backgroundColor = UIColor(rgb: 0x1E1F24)
        }
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            appDescription,
            inputLabel,
            zodiacInput,
            getDetailsButton
        ])
        stackView.axis = .vertical
        stackView.distribution = .fill
        let screenSize = UIScreen.main.bounds.size
        let spacing = screenSize.width < 410 ? 8 : 18
        stackView.spacing = CGFloat(spacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        spacingConstraints()
    }
    
    func spacingConstraints() {
        appDescription.translatesAutoresizingMaskIntoConstraints = false
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            appDescription.bottomAnchor.constraint(equalTo: inputLabel.topAnchor, constant: -100),
            inputLabel.leadingAnchor.constraint(equalTo: appDescription.leadingAnchor)
        ])
    }
    
    func styleTitle() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = UIColor(rgb: 0xFFFFFF)
    }
    
    func styleDescription() {
        appDescription.font = UIFont.preferredFont(forTextStyle: .body)
        appDescription.textColor = UIColor(rgb: 0x8B8B8B)
        appDescription.numberOfLines = 0
    }
    
    func styleLabel() {
        inputLabel.font = UIFont.preferredFont(forTextStyle: .body)
        inputLabel.font = inputLabel.font.withSize(16.0)
        inputLabel.textColor = UIColor(rgb: 0xFFFFFF)
    }
    
    func styleTextField() {
        zodiacInput.backgroundColor = UIColor.clear
        zodiacInput.borderStyle = .roundedRect
        zodiacInput.layer.borderWidth = 1
        zodiacInput.layer.borderColor = UIColor(rgb: 0xDDDDDD).cgColor
        zodiacInput.layer.cornerRadius = 4
        zodiacInput.textColor = UIColor.white
    }
    
    func styleButton() {
        getDetailsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        getDetailsButton.backgroundColor = UIColor(rgb: 0x5000B6)
        getDetailsButton.setTitleColor(.white, for: .normal)
        getDetailsButton.layer.cornerRadius = 12
        getDetailsButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    
    
    // MARK: - ACTION FUNCTIONS
    
    func initNavigation() {
        navigate(getDetailsButton)
    }
    
    func navigate(_ button: UIButton) {
        button.addAction(UIAction(title: "დეტალები", handler: { [weak self] _ in
            guard let self = self, let text = self.zodiacInput.text, !text.isEmpty else {
                return
            }
            let detailsVC = DetailsVC()
            detailsVC.modalPresentationStyle = .fullScreen
            detailsVC.data = zodiacSigns.first(where: { $0.sign == text })
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }), for: .touchUpInside)
    }

}

#Preview {
    ViewController()
}




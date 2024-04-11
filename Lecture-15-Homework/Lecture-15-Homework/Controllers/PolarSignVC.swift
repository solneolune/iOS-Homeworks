//
//  PolarSignVC.swift
//  Lecture-15-Homework
//
//  Created by Barbare Tepnadze on 11.04.24.
//

import UIKit

class PolarSignVC: BaseVC {
    
    // MARK: - PROPERTIES
    
    var data: Zodiac?
    
    
    // MARK: - ELEMENTS
    
    let polarSymbol: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    

    let redButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("წითელი", for: .normal)
        return button
    }()
    
    let blueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ლურჯი", for: .normal)
        return button
    }()
    
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        initData()
        navRedButton()
        navBlueButton()
    }
    
    
    
    // MARK: - INIT AND STYLE FUNCTIONS
    
    func initSetUp() {
        initBackgroundColor()
        initStackView()
        styleImage()
        styleTitle()
        styleButtons([redButton, blueButton])
        styleRedButton()
        styleBlueButton()
    }
    
    func initBackgroundColor() {
        view.backgroundColor = UIColor(rgb: 0x1E1F24)
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            polarSymbol,
            titleLabel,
            redButton,
            blueButton
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
            titleLabel.text = data.polarSign
            loadImage(from: data, for: polarSymbol)
        } else {
            titleLabel.text = "404 not found"
        }
    }
    
    func styleImage() {
        polarSymbol.contentMode = .scaleAspectFit
        polarSymbol.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: polarSymbol, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0)
        let heightConstraint = NSLayoutConstraint(item: polarSymbol, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 300.0)
        polarSymbol.addConstraints([widthConstraint, heightConstraint])
    }
    
    func styleTitle() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = UIColor(rgb: 0xFFFFFF)
        titleLabel.textAlignment = .center
    }
    
    func styleButtons(_ buttons: [UIButton]) {
        for button in buttons {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 12
            button.heightAnchor.constraint(equalToConstant: 46).isActive = true
        }
    }
    
    func styleRedButton() {
        redButton.backgroundColor = UIColor(rgb: 0xB61600)
    }
    
    func styleBlueButton() {
        blueButton.backgroundColor = UIColor(rgb: 0x0049B6)
    }
    
    // MARK: - ACTION FUNCTIONS
    
    func loadImage(from sign: Zodiac, for imageView: UIImageView) {
        guard let signImg = sign.polarSymbol else {
            return
        }
        if let image = UIImage(named: signImg) {
            polarSymbol.image = image
            return
        }
    }
    
    func navigate(_ button: UIButton, _ color: UIColor) {
        button.addAction(UIAction(title: "მთავარ გვერდზე დაბრუნება", handler: { [weak self] _ in
            guard let self = self, let text = self.titleLabel.text, !text.isEmpty else {
                return
            }
            let mainVC = ViewController()
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.bgColor = color
            self.navigationController?.pushViewController(mainVC, animated: true)
        }), for: .touchUpInside)
    }
    
    func navRedButton() {
        redButton.addAction(UIAction(title: "მთავარ გვერდზე დაბრუნება", handler: { [weak self] _ in
            guard let self = self, let text = self.titleLabel.text, !text.isEmpty else {
                return
            }
            let mainVC = ViewController()
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.bgColor = .red
            self.navigationController?.pushViewController(mainVC, animated: true)
        }), for: .touchUpInside)
    }
    
    func navBlueButton() {
        blueButton.addAction(UIAction(title: "მთავარ გვერდზე დაბრუნება", handler: { [weak self] _ in
            guard let self = self, let text = self.titleLabel.text, !text.isEmpty else {
                return
            }
            let mainVC = ViewController()
            mainVC.modalPresentationStyle = .fullScreen
            mainVC.bgColor = .blue
            self.navigationController?.pushViewController(mainVC, animated: true)
        }), for: .touchUpInside)
    }
}


// MARK: - Preview
#Preview {
    PolarSignVC()
}

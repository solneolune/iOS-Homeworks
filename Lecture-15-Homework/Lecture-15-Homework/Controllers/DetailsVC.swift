//
//  DetailsVC.swift
//  Lecture-15-Homework
//
//  Created by Barbare Tepnadze on 10.04.24.
//

import UIKit

class DetailsVC: BaseVC {
    
    // MARK: - PROPERTIES
    
    var data: Zodiac?
    
    
    
    // MARK: - ELEMENTS
    
    let signSymbol: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let zodiacDescription: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    let getPolarSignButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("პოლარული ნიშანი", for: .normal)
        return button
    }()
    
    
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        initData()
        navigate(getPolarSignButton)
    }
    

    
    // MARK: - INIT AND STYLE FUNCTIONS
    
    func initSetUp() {
        initBackgroundColor()
        initStackView()
        styleImage()
        styleTitle()
        styleDescription()
        styleButton()
    }
    
    func initBackgroundColor() {
        view.backgroundColor = UIColor(rgb: 0x1E1F24)
    }
    
    func initStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            signSymbol,
            titleLabel,
            zodiacDescription,
            getPolarSignButton
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
            titleLabel.text = data.sign
            zodiacDescription.text = data.description
            loadImage(from: data, for: signSymbol)
        } else {
            titleLabel.text = "404 not found"
        }
    }
    
    func styleImage() {
//        signSymbol.frame.size = CGSize(width: 156, height: 156)
        signSymbol.contentMode = .scaleAspectFit //
        signSymbol.translatesAutoresizingMaskIntoConstraints = false

        let widthConstraint = NSLayoutConstraint(item: signSymbol, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 156.0)
        let heightConstraint = NSLayoutConstraint(item: signSymbol, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 156.0)
        signSymbol.addConstraints([widthConstraint, heightConstraint])
    }
    
    func styleTitle() {
        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.textColor = UIColor(rgb: 0xFFFFFF)
        titleLabel.textAlignment = .center
    }
    
    func styleDescription() {
        zodiacDescription.font = UIFont.preferredFont(forTextStyle: .body)
        zodiacDescription.font = zodiacDescription.font?.withSize(14.0)
        zodiacDescription.textColor = UIColor(rgb: 0xFFFFFF)
        zodiacDescription.backgroundColor = .clear
        zodiacDescription.isEditable = false
    }
    
    func styleButton() {
        getPolarSignButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        getPolarSignButton.backgroundColor = UIColor(rgb: 0x5000B6)
        getPolarSignButton.setTitleColor(.white, for: .normal)
        getPolarSignButton.layer.cornerRadius = 12
        getPolarSignButton.heightAnchor.constraint(equalToConstant: 46).isActive = true
    }
    
    
    
    // MARK: - ACTION FUNCTIONS
    
    func loadImage(from sign: Zodiac, for imageView: UIImageView) {
        guard let signImg = sign.signSymbol else {
            return
        }
        if let image = UIImage(named: signImg) {
            signSymbol.image = image
            return
        }
    }
    
    func navigate(_ button: UIButton) {
        button.addAction(UIAction(title: "პოლარული ნიშანი", handler: { [weak self] _ in
            guard let self = self, let text = self.titleLabel.text, !text.isEmpty else {
                return
            }
            let polarVC = PolarSignVC()
            polarVC.modalPresentationStyle = .fullScreen
            polarVC.data = zodiacSigns.first(where: { $0.sign == text })
            self.navigationController?.pushViewController(polarVC, animated: true)
        }), for: .touchUpInside)
    }
}


// MARK: - Preview
#Preview {
    DetailsVC()
}

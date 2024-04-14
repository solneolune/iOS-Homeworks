//
//  OnboardingVC.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class OnboardingVC: BaseVC {
    
    // MARK: - Elements
    let titleLabel = UILabel()
    let startButton = AppButton(title: "დაწყება", color: UIColor(rgb: 0x0075FF), width: 123)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
        startComplaining(startButton)
    }
    
    // MARK: - Setup and Styling
    override func initBackground() {
        super.initBackground()
        if let bgImageView = view.subviews.first as? UIImageView {
            bgImageView.image = UIImage(named: "bg.png")
        }
    }
    
    func initSetUp() {
        styleLabel()
        styleButton()
    }
    
    func styleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor(rgb: 0xFFFFFF)
        titleLabel.font = UIFont(name: "FiraGO-Regular", size: 30)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.33
        titleLabel.attributedText = NSMutableAttributedString(string: "შედი \nაპლიკაციაში \nდა იწუწუნე \nრამდენიც გინდა", attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func styleButton() {
        view.addSubview(startButton)
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 90),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            startButton.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20)
        ])
    }

    // MARK: - Action Functions
    func startComplaining(_ button: UIButton) {
        button.addAction(UIAction(title: "წუწუნი Hub", handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            let mainVC = ViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(mainVC, animated: true)
        }), for: .touchUpInside)
    }
}

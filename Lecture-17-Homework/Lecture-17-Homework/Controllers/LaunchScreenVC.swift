//
//  LaunchScreenVC.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class LaunchScreenVC: BaseVC {
    
    // MARK: - Elements
    let welcomeText = UILabel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetUp()
    }

    // MARK: - Setup and Styling
    func initSetUp() {
        initText()
    }
    
    func initText() {
        welcomeText.text = "წუწუნი Hub"
        styleWelcomeText()
        view.addSubview(welcomeText)
        addTextConstraints()
    }
    
    func styleWelcomeText() {
        welcomeText.textAlignment = .center
        welcomeText.textColor = UIColor(rgb: 0xFFFFFF)
        welcomeText.font = UIFont.preferredFont(forTextStyle: .title1)
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
    }

    func addTextConstraints() {
        welcomeText.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        welcomeText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}

#Preview {
    LaunchScreenVC()
}


//
//  AppButton.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class AppButton: UIButton {
    
    // MARK: - Init
    init(title: String, color: UIColor, width: CGFloat) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.backgroundColor = color
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        styleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Styling
    func styleButton() {
        self.heightAnchor.constraint(equalToConstant: 46).isActive = true
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.setTitleColor(.white, for: .normal)
        self.layer.cornerRadius = 24
    }
    
    // MARK: - Set Properties
    func setProperties(title: String?, color: UIColor?, width: CGFloat?) {
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        if let color = color {
            self.backgroundColor = color
        }
        if let width = width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}


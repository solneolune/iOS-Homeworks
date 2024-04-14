//
//  UIFont.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

extension UIFont {
    static func overrideDefaultFont() {
        guard let customFont = UIFont(name: "FiraGO-Regular", size: UIFont.labelFontSize) else { return }
        UILabel.appearance().font = customFont
        UIButton.appearance().titleLabel?.font = customFont
        UITextField.appearance().font = customFont
        UITextView.appearance().font = customFont
    }
}


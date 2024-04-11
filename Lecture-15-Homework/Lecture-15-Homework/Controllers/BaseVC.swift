//
//  BaseVC.swift
//  Lecture-15-Homework
//
//  Created by Barbare Tepnadze on 11.04.24.
//

import UIKit

// MARK: - EXTRA
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

class BaseVC: UIViewController {

    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
    }
  
    
    // MARK: - STYLE FUNCTIONS
    
    func initBackground() {
        let bgImgViewer = UIImageView(frame: UIScreen.main.bounds)
        bgImgViewer.image = UIImage(named: "background.png")
        bgImgViewer.contentMode = .scaleAspectFill
        bgImgViewer.clipsToBounds = true
        
        view.addSubview(bgImgViewer)
        view.sendSubviewToBack(bgImgViewer)
        
        bgImgViewer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgImgViewer.topAnchor.constraint(equalTo: view.topAnchor),
            bgImgViewer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgImgViewer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImgViewer.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}


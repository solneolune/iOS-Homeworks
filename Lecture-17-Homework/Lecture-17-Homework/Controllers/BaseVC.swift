//
//  BaseVC.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class BaseVC: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackground()
    }
  
    // MARK: - STYLE FUNCTIONS
    func initBackground() {
        let bgImgViewer = UIImageView(frame: UIScreen.main.bounds)
        bgImgViewer.image = UIImage(named: "basic-bg.png")
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

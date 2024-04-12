//
//  SceneDelegate.swift
//  Lecture-16-Homework
//
//  Created by Barbare Tepnadze on 12.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let homeVC = ViewController()
        let detailsVC = DetailsVC()
        detailsVC.title = "უკან"
        
        let nav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  Lecture-15-Homework
//
//  Created by Barbare Tepnadze on 10.04.24.
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
        let polarVC = PolarSignVC()
        polarVC.title = "უკან" // ეს ვერ გავიგე რანაირად ვქნა
        
        
        let nav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

//
//  SceneDelegate.swift
//  Lecture-23-Homework
//
//  Created by Barbare Tepnadze on 03.05.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let mainVC = CatFactsViewController()
        let nav = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}


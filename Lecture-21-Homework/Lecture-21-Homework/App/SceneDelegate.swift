//
//  SceneDelegate.swift
//  Lecture-21-Homework
//
//  Created by Barbare Tepnadze on 25.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let homeVC = CountriesViewController()
        let nav = UINavigationController(rootViewController: homeVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}

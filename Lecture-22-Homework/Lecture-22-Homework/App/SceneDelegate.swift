//
//  SceneDelegate.swift
//  Lecture-22-Homework
//
//  Created by Barbare Tepnadze on 26.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let homeVC = CountriesViewController()
        let loginVM = LogInViewModel()
        let loginVC = LogInViewController(viewModel: loginVM)
        var nav = UINavigationController()
        
        if KeychainHelper.retrieve() != nil {
            nav = UINavigationController(rootViewController: homeVC)
        } else {
            nav = UINavigationController(rootViewController: loginVC)
        }
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
    }
}

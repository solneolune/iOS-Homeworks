//
//  SceneDelegate.swift
//  Lecture-17-Homework
//
//  Created by Barbare Tepnadze on 14.04.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let launchVC = LaunchScreenVC()
        let onboardingVC = OnboardingVC()
        
        let nav = UINavigationController(rootViewController: onboardingVC)
        
        window?.rootViewController = launchVC
        window?.makeKeyAndVisible()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.window?.rootViewController = nav
        }
    }
}

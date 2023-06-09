//
//  SceneDelegate.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator.start()
    }
}


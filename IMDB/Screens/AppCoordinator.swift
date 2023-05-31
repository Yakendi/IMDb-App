//
//  AppCoordinator.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var window: UIWindow
    var navigationController = UINavigationController()
    
    // MARK: - Constructor
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        /*
         
         if user.isAuth {
         
         } else {
            // 
         }
         
         
         */
        let controller = TabBarController()
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}

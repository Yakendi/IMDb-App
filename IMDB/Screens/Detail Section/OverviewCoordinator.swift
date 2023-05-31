//
//  DetailCoordinator.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import UIKit

final class OverviewCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
        let controller = OverviewViewFactory.create()
        self.navigationController.setViewControllers([controller], animated: true)
    }
}

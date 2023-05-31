//
//  SearchCoordinator.swift
//  IMDB
//
//  Created by Аслан Микалаев on 21.05.2023.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
        let controller = SearchViewFactory.create()
        self.navigationController.setViewControllers([controller], animated: true)
    }
}

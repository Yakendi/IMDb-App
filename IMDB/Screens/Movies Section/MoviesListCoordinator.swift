//
//  MoviesListCoordinator.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

class MoviesListCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
        let controller = MoviesListViewFactory.create()
        controller.delegate = self
        self.navigationController.setViewControllers([controller], animated: true)
    }
}

extension MoviesListCoordinator: Presenter {
    func showDetail(_ model: MostPopularDetail) {
        let vc = OverviewViewController()
        vc.configure(model)
        self.navigationController.topViewController?.present(vc, animated: true)
    }
}

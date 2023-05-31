//
//  TopListCoordinatoe.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

final class TopListCoordinator: Coordinator {
    
    // MARK: - Public
    var navigationController: UINavigationController
    
    // MARK: - Constructor
    init() {
        self.navigationController = UINavigationController()
        
        start()
    }
    
    func start() {
        let controller = TopListViewFactory.create()
        controller.delegate = self
        self.navigationController.setViewControllers([controller], animated: true)
    }
}

extension TopListCoordinator: Presenter {
    func showDetail(_ model: MostPopularDetail) {
        let vc = OverviewViewController()
        vc.configure(model)
        self.navigationController.topViewController?.present(vc, animated: true)
    }
}

//
//  RootViewFactory.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

struct MoviesListViewFactory {
    static func create() -> MoviesListViewController {
        let viewController = MoviesListViewController()
        return viewController
    }
}

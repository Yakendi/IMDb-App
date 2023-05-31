//
//  TVSeriesListFactory.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

struct TVShowsListViewFactory {
    static func create() -> TVShowsListViewController {
        let controller = TVShowsListViewController()
        return controller
    }
}

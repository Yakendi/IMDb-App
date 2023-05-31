//
//  TabBarController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

enum TabBarItems {
    case movies
    case tvs
    case top
    case search
    
    var title: String {
        switch self {
        case .movies:
            return "Movies"
        case .tvs:
            return "TVs"
        case .top:
            return "Top"
        case .search:
            return "Search"
        }
    }

    var image: UIImage {
        switch self {
        case .movies:
            return UIImage(systemName: "popcorn") ?? UIImage()
        case .tvs:
            return UIImage(systemName: "film.stack") ?? UIImage()
        case .top:
            return UIImage(systemName: "star") ?? UIImage()
        case .search:
            return UIImage(systemName: "magnifyingglass") ?? UIImage()
        }
    }
}

final class TabBarController: UITabBarController {
    
    // MARK: - Public
    let moviesList = MoviesListCoordinator()
    let tvShowsList = TVShowsListCoordinator()
    let topList = TopListCoordinator()
    let search = SearchCoordinator()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
        tabBar.tintColor = .systemRed
    }
}

// MARK: - Tabs
private extension TabBarController {
    func setupTabs() {
        
        moviesList.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.movies.title,
            image: TabBarItems.movies.image,
            tag: 1
        )
        tvShowsList.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.tvs.title,
            image: TabBarItems.tvs.image,
            tag: 2
        )
        topList.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.top.title,
            image: TabBarItems.top.image,
            tag: 3)
        search.navigationController.tabBarItem = UITabBarItem(
            title: TabBarItems.search.title,
            image: TabBarItems.search.image,
            tag: 4)
        
        setViewControllers([moviesList.navigationController, tvShowsList.navigationController, topList.navigationController, search.navigationController], animated: true)
    }
}

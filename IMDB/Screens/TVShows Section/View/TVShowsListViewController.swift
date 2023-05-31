//
//  TVsListViewController.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

class TVShowsListViewController: BaseProductionsListViewController {
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TVs"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
    }
    
    // MARK: - Networking
    override func fetchData() {
        
        self.network.getTVsList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case (.success(let data)):
                self.dataSource = data.items
            case (.failure(_)):
                DispatchQueue.main.async {
                    self.showAlert(title: NetworkErrorTypes.emptyData.errorDescription ?? "Error")
                }
            }
        }
    }
}

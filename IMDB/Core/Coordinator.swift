//
//  Coordinator.swift
//  IMDB
//
//  Created by Аслан Микалаев on 20.05.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}

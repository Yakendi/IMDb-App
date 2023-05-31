//
//  UIViewController+extension.swift
//  IMDB
//
//  Created by Аслан Микалаев on 26.05.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}

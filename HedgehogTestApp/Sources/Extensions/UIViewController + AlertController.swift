//
//  UIViewController + AlertController.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 11.02.2023.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        if actions.isEmpty {
            let defaultAction = UIAlertAction(title: "Ok", style: .default)
            alertController.addAction(defaultAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}

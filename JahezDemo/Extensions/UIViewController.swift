//
//  UIViewController.swift
//  JahezDemo
//
//  Created by Ahmed Elashker on 17/01/2023.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(error: Error,
                        retryBlock: ((UIAlertAction) -> Void)? = nil) {
        
        let networkError = error as? NetworkError
        self.showAlert(title: networkError?.title,
                       message: networkError?.message,
                       retryBlock: retryBlock)
    }
    
    func showAlert(title: String?,
                   message: String?,
                   retryBlock: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Retry",
                                      style: UIAlertAction.Style.default, handler: retryBlock))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: UIAlertAction.Style.destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

//
//  CommonExtensions.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/14/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController: BaseErrorDelegation {
    
    ///Shows alert dialog
    /// - Parameter title: the title of the alert box
    /// - Parameter message: the message of the alert box
    public func showAlert(title: String, message: String, dismissable: Bool = false) -> UIAlertController{
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if(dismissable) {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
        return alert
        
    }

    
    func onFail(error: BaseError) {
        showAlert(title: "Error", message: error.defaultMessage, dismissable: true)
    }
}

//
//  RegisterViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: Properties

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //MARK: Default
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Actions
    
    @IBAction public func onRegister(_ sender: UIButton) {
        if(self.emailField?.text == "") {
            self.showAlert(title: "Error", message: "Email field is requried")
        }else if(self.nameField?.text == "") {
            self.showAlert(title: "Error", message: "Message field is requried")
        }else if(self.passwordField?.text == ""){
            self.showAlert(title: "Error", message: "Password field is requried")
        }else{
            debugPrint("Pass")
        }
        
    }
    
    ///Shows alert dialog
    /// - Parameter title: the title of the alert box
    /// - Parameter message: the message of the alert box
    private func showAlert(title: String, message: String){
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

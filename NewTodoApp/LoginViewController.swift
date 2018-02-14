//
//  ViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthenticationServiceDelegate {
    
    ///MARK: Properties
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var authService: AuthenticationService = AuthenticationService()
    
    
    ///MARK: Defaults
    override func viewDidLoad() {
        super.viewDidLoad()
        self.authService.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
//        ProcessInfo
        // Dispose of any resources that can be recreated.
    }
    
    ///MARK: Actions

    ///Login button click event
    @IBAction func onLogin(_ sender: UIButton) {
        if(self.emailField?.text == "") {
            self.showAlert(title: "Error", message: "Email field is required", dismissable: true)
        }else if(self.passwordField?.text == "") {
            self.showAlert(title: "Error", message: "Password field is required", dismissable: true)
        }else{
            self.authService.login(email: self.emailField.text!, password: self.passwordField.text!)
        }
    }
    
    ///Shows alert dialog
    /// - Parameter title: the title of the alert box
    /// - Parameter message: the message of the alert box
    private func showAlert(title: String, message: String, dismissable: Bool = false) -> UIAlertController{
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if(dismissable) {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
        }
        
        
        self.present(alert, animated: true, completion: nil)
        
        return alert
        
    }
    
    ///Function is called on login authentication fail through delegation
    public func onLoginFail(error: ResponseError) {
        
        if(error.errors!.isEmpty == true){
            self.showAlert(title: "Error", message: error.defaultError, dismissable: true)
        }else{
            self.showAlert(title: "Error", message: error.errors![0], dismissable: true)
        }
    }
    
    public func onLoginSuccess(data: LoginModel) {
        //MARK: Todo
        debugPrint("success")
    }

}


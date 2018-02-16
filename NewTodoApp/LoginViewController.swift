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
    
    public func onLoginFail(error: ValidationError) {
        let message: String = error.errors?.isEmpty == true ? error.defaultMessage : (error.errors?.first!)!
        self.showAlert(title: "Error", message: message, dismissable: true)
    }
    
    public func onLoginSuccess(data: Login) {
        //first saving the access token and refresh token in user defaults
        let defaults = UserDefaults.standard
        defaults.set(data.accessToken, forKey: defaultKeyStructure.accessToken)
        defaults.set(data.refreshToken, forKey: defaultKeyStructure.refreshToken)
        
        
        //now take the user to dashboard
    }
}


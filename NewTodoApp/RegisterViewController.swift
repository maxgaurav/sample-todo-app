//
//  RegisterViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, AuthenticationServiceRegisterDelegate {
    
    //MARK: Properties

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authenticationService: AuthenticationService = AuthenticationService()
    
    //MARK: Default
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.authenticationService.registerDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: Actions
    
    @IBAction public func onRegister(_ sender: UIButton) {
        if(self.emailField?.text == "") {
            self.showAlert(title: "Error", message: "Email field is requried", dismissable: true)
        }else if(self.nameField?.text == "") {
            self.showAlert(title: "Error", message: "Message field is requried", dismissable: true)
        }else if(self.passwordField?.text == ""){
            self.showAlert(title: "Error", message: "Password field is requried", dismissable: true)
        }else{
            self.authenticationService.register(email: self.emailField.text!, password: self.passwordField.text!, name: self.nameField.text!)
        }
    }
    
    
    ///MARK: Delegations
    ///MARK: Register Delegations
    
    
    ///Function is called when register service is successfull
    public func onRegisterSuccess(data: Login) {
        let defaults = UserDefaults.standard
        defaults.set(data.accessToken, forKey: defaultKeyStructure.accessToken)
        defaults.set(data.refreshToken, forKey: defaultKeyStructure.refreshToken)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController(storboardName: "Dashboard", viewControllerIdentifier: "DashboardNavigation")
    }
    
    ///Function is called when register service fails
    public func onRegisterFail(errors: ValidationError) {
        let message = errors.errors?.isEmpty == true || errors.errors == nil ? errors.defaultMessage : errors.errors?.first!
        showAlert(title: "Error", message: message!, dismissable: true)
    }

}

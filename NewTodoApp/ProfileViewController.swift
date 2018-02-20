//
//  ProfileViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileViewController: UIViewController,UserServiceDelegation, AuthenticationServiceLogoutDelegate {
    
    //MARK: Properties
    @IBOutlet weak var nameField: UITextField!
    
    var userService: UserService = UserService()
    var authenticationService: AuthenticationService = AuthenticationService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.authenticationService.logoutDelegate = self
        self.userService.delegate = self
        self.userService.getUser()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    
    ///Function is called on update button click
    @IBAction func onUpdate(_ sender: UIButton) {
        self.userService.updateUser(user: [
                "name": self.nameField.text!
            ])
    }
    
    ///Function is called on edit button click
    @IBAction func onLogoutClick(_ sender: UIButton) {
        self.authenticationService.logout()
    }
    
    
    //MARK: Delegate Events
    
    ///Function is called when updation of user fails
    /// - Parameter errors: Contains the error messages
    public func onUserUpdateFail(errors: ValidationError) {
        
    }
    
    ///Function is called when user fetch is successfull
    /// - Parameter data: Contains fetched user data
    public func onUserFetchSuccess(data: User) {
        self.nameField.text = data.name!
        
    }
    
    /// Function is called when user update fails
    /// - Parameter errors: Contains the error messages
    public func onUserFetchFail(errors: ValidationError) {
        let message: String = errors.errors?.isEmpty == true ? errors.defaultMessage : (errors.errors?.first!)!
        self.showAlert(title: "Error", message: message, dismissable: true)
        
    }
    
    /// Function is called when user update succeeds
    /// - Parameter data: Contains the newly updated user data
    public func onUserUpdateSuccess(data: User) {
        
    }
    
    /// MARK: Logout delegate
    public func onLogoutSuccess(data: Base) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController(storboardName: "Main", viewControllerIdentifier: "Login")
    }
    
    public func onLogoutFail(error: ValidationError) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.changeRootViewController(storboardName: "Main", viewControllerIdentifier: "Login")
    }

}

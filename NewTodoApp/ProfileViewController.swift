//
//  ProfileViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UserServiceDelegation {
    
    //MARK: Properties
    @IBOutlet weak var nameField: UITextField!
    
    var userService: UserService = UserService()

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    public func onUserUpdateFail() {
        
    }
    
    public func onUserUpdateSuccess() {
        
    }
    
    public func onUserFetchSuccess(data: User) {
        self.nameField.text = data.name!
        
    }
    
    public func onUserFetchFail(errors: ValidationError) {
        let message: String = errors.errors?.isEmpty == true ? errors.defaultMessage : (errors.errors?.first!)!
        self.showAlert(title: "Error", message: message, dismissable: true)
        
    }
    
    
    

}

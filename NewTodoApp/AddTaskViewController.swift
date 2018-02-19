//
//  AddTaskViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/19/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, TaskServiceAddDelegation {
    
    
    ///Mark: Properties
    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    var taskService: TaskService = TaskService()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskService.addDelegation = self

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
    
    ///Mark: Actions
    @IBAction func onAddClick(_ sender: UIButton) {
        self.taskService.addTask(title: self.taskField.text!, description: self.descriptionField.text!)
    }
    
    
    ///Mark: TaskServiceAdd Delegations
    
    ///Function is called on task is added successfully
    /// Parameter data: Task object model that was added
    public func onTaskAddSuccess(data: Task) {
        self.taskField.text = ""
        self.descriptionField.text = ""
        showAlert(title: "Success", message:"Task added successfully", dismissable: true)
    }
    
    ///Function is called on task is add fails
    /// Parameter errors: Error messages received from server
    public func onTaskAddFail(errors: ValidationError) {
        let message = errors.errors?.isEmpty == true ? errors.defaultMessage : errors.errors?.first
        self.showAlert(title: "Error", message: message!, dismissable: true)
    }

}

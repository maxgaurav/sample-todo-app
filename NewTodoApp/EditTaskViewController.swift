//
//  EditTaskViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/19/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class EditTaskViewController: UIViewController,TaskServiceEditDelegation {

    ///Mark: Properties
    var task:Task?
    var taskService: TaskService = TaskService()
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskService.editDelegation = self

        // Do any additional setup after loading the view.
        self.setUpFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///Function setups the field content
    func setUpFields() {
        self.titleField.text = self.task?.title!
        self.descriptionField.text = self.task?.description!
    }
    
    
    ///Mark: Delegations
    
    ///Mark: Task Edit Delegation
    public func onTaskEditSuccess(data: Task) {
        self.showAlert(title: "Success", message: "Task was updated successfully", dismissable: true)
    }
    
    public func onTaskEditFail(errors: ValidationError) {
        let message = errors.errors?.isEmpty == true ? errors.defaultMessage : errors.errors?.first!
        self.showAlert(title: "Error", message: message!, dismissable: true)
    }
    
    
    ///Mark: TaskService Fetch Delegation
    
    ///Mark Actions
    @IBAction func onUpdateClick(_ sender: UIButton) {
        self.taskService.editTask(taskId: (self.task?.id!)!, title: self.titleField.text!, description: self.descriptionField.text!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

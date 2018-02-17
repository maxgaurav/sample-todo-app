//
//  DashboardViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, TaskServiceDelegation {

    //MARK: Properties
    let taskService: TaskService = TaskService();
    
    var tasks: [Task] = []
    
    override func viewWillAppear(_ animated: Bool) {
        self.edgesForExtendedLayout = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.taskService.delegate = self
        self.taskService.getTasks()
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
    
    ///Func is called when tasks has been fetched successfully
    /// - Parameter: data - Contains the main Tasks Model
    public func onTasksFetchSuccess(data: Tasks) {
        self.tasks = data.tasks!
    }
    
    ///Function is called when tasks fetch fails
    /// Parameter errors: Contains the error message regariding the failure
    public func onTasksFetchFail(errors: ValidationError) {
        let message = errors.errors?.isEmpty == true ? errors.defaultMessage : errors.errors?.first!
        
        showAlert(title: "Error", message: message!)
    }

}

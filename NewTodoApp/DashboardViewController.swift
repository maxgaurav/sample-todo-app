//
//  DashboardViewController.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, TaskServiceFetchDelegation, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Propertie
    var tasks: [Task] = []
    let taskService: TaskService = TaskService()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.taskService.getTasks()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.taskService.fetchDelegation = self
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
        self.tableView.reloadData()
    }
    
    ///Function is called when tasks fetch fails
    /// Parameter errors: Contains the error message regariding the failure
    public func onTasksFetchFail(errors: ValidationError) {
        let message = errors.errors?.isEmpty == true ? errors.defaultMessage : errors.errors?.first!
        
        showAlert(title: "Error", message: message!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tasks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "DashboardTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DashboardTableViewCell  else {
            fatalError("The dequeued cell is not an instance of DashboardTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let task = tasks[indexPath.row]
        
        cell.taskTitle.text = task.title!
        cell.taskDescription.text = task.description!
        
        return cell
    }
 

}

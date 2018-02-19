//
//  DashboardTableViewCell.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/17/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    //MARK: Properties

    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var taskDescription: UILabel!

    var task:Task!
    var taskIndex:Int = -1
    
    var taskService: TaskService = TaskService()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    ///Mark: Actions
    
    @IBAction func onRemoveClick(_ sender: Any) {
        self.taskService.removeTask(taskId: self.task.id!)
    }
    
    

    
    //////Mark: Task Delete Delegations
    public func onTaskDeletedSucces(taskId: Int) {
        //code need to remove task
    }
    
    public func onTaskDeleteFail(errors: ValidationError) {

    }
}

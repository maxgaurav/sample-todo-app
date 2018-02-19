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
    var delegation: DashboardCellDelegation?
    
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
    
    @IBAction func onEditClick(_ sender: UIButton) {
        self.delegation?.editClick(task: self.task!)
    }
}

protocol DashboardCellDelegation {
    func editClick(task: Task)
}

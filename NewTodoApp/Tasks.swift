//
//  Tasks.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/17/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class Tasks: Base {
    var tasks: [Task]?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.tasks <- map["tasks"]
    }
}

class Task: Base {
    
    var id: Int?
    var title: String?
    var description: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
    }
    
}

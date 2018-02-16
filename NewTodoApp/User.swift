//
//  User.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class User:Base {

    var userId: Int?
    var name:String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        userId <- map["user.id"]
        name <- map["user.name"]
    }
}

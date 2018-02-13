//
//  BaseModel.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    var status: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
}

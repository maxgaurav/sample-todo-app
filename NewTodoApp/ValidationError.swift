//
//  ValidationError.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class ValidationError: BaseError {
    
    var errors: [String]? = []
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    public override func mapping(map: Map) {
        debugPrint(map)
        super.mapping(map: map)
        errors <- map["errors"]
    }
}

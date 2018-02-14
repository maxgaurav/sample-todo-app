//
//  BaseError.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/14/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseError: Base {
    
    var defaultMessage: String = "Something went wrong"
    
    override func mapping(map: Map) {
        super.mapping(map: map)
    }
}

//
//  BaseModel.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class Base: Mappable {
    var status: String?
    
    var statusCode: Int = 200
    
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        status <- map["status"]
    }
    
    ///Sets the status code the model object is received from
    /// - Parameter code: The status code to be set
    public func setStatusCode(_ code:Int) {
        self.statusCode = code
    }
}

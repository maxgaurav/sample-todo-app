//
//  LoginModel.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginModel: BaseModel {
    var token: String?
    var user:UserModel?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        user <- map["user"]
    }
}

class UserModel: Mappable {
    var name:String?
    var email:String?
    var id:Int?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        id <- map["id"]
    }
}

//
//  LoginModel.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import ObjectMapper

class Login: Base {
    var tokenType: String?
    var expiresIn: Int?
    var accessToken: String?
    var refreshToken: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        tokenType <- map["token_type"]
        expiresIn <- map["expiresIn"]
        refreshToken <- map["refresh_token"]
        accessToken <- map["access_token"]
    }
}

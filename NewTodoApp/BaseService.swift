//
//  BaseService.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
    
    //MARK: Properties
    
    public var baseHeader: HTTPHeaders = [
        "Accept" : "application/json"
    ]

    var clientSecret: String;
    var clientId: String;
    var helper: Helper = Helper()
    var baseUrl:String
    var apiVersion:String
    
    init() {
        
        self.clientId = self.helper.getEnv(key: "clientId")
        self.clientSecret = self.helper.getEnv(key: "clientSecret")
        self.baseUrl = self.helper.getEnv(key: "baseUrl")
        self.apiVersion = self.helper.getEnv(key: "apiVersion")
        debugPrint(self.baseUrl)
        debugPrint(self.clientSecret)
        debugPrint(self.apiVersion)
        debugPrint(self.clientId)
    }
    
    ///Returns the actual url that needs to be fired
    /// - Parameter url: identifier segment
    public func getUrl(url: String) -> String {
        return self.baseUrl + "/" + self.apiVersion + "/" + url;
    }
}

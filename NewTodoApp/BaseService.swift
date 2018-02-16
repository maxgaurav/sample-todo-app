//
//  BaseService.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol BaseErrorDelegation {
    func onFail(error: BaseError)
}

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
    
    var baseErrorDelegate: BaseErrorDelegation?
    var queue:DispatchQueue = DispatchQueue(label:"NetworkService")
    
    init() {
        
        self.clientId = self.helper.getEnv(key: "clientId")
        self.clientSecret = self.helper.getEnv(key: "clientSecret")
        self.baseUrl = self.helper.getEnv(key: "baseUrl")
        self.apiVersion = self.helper.getEnv(key: "apiVersion")
    
    }
    
    ///Returns the actual url that needs to be fired
    /// - Parameter url: identifier segment
    public func getUrl(url: String) -> String {
        return self.baseUrl + "/" + self.apiVersion + "/" + url;
    }
    
    /// Function fetches new access token with refresh token
    public func refreshToken() {
        let defaults = UserDefaults.standard
        let parameters:Parameters = [
            "client_id" : self.clientId,
            "client_secret": self.clientSecret,
            "grant_type": "refresh_token",
            "refresh_token": defaults.string(forKey: defaultKeyStructure.refreshToken)!
        ]
        
        Alamofire.request(self.getUrl(url: "oauth/token"), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        let json = String(data: data, encoding: .utf8)
                        let login = Mapper<Login>().map(JSONString: json!)
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                }
        }
            
        
    }
    
}

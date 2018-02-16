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
    var queue:DispatchQueue = DispatchQueue(label:"NetworkService",  qos: .utility, attributes: [.concurrent])
    
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
                        self.setStatusCode(model: login!, response: response)
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                }
        }
    }
    
    ///Sets the status code retrieved from the server for the response
    /// - Parameter model: The model object where the status code needs to be set
    /// - Parameter response: The response object provided by the Alamofire
    func setStatusCode(model: Base, response: DataResponse<Any>){
        if let statusCode = response.response?.statusCode {
            model.setStatusCode(statusCode)
        }

    }
    
}

//
//  AuthenticationService.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AuthenticationService: BaseService {
    
    var delegate: AuthenticationServiceDelegate!

    
    ///Calls login api
    /// - Parameter email: Email of user
    /// - Parameter password: Password of user
    public func login(email: String, password: String) {
        let parameters: Parameters = [
            "email" : email,
            "password": password,
            "client_id" : self.clientId,
            "client_secret": self.clientSecret
        ]
        
        Alamofire.request(self.getUrl(url: "auth/login"), method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: self.baseHeader)
            .validate()
            .responseJSON { response in
                switch response.result{
                    case .success:
                        if let data = response.data {
                            let json = String(data: data, encoding: .utf8)
                            
                            let login = Mapper<LoginModel>().map(JSONString: json!)
                            
                            self.delegate?.onLoginSuccess(data: login!)
                        }else{
                            let errors = Mapper<ResponseError>().map(JSONString: "")
                            self.delegate?.onLoginFail(error: errors!)
                        }
                    
                    case .failure:
                        
                        if let data = response.data {
                            let json = String(data: data, encoding: String.Encoding.utf8)
                            let errors = Mapper<ResponseError>().map(JSONString: json!)
                            self.delegate?.onLoginFail(error: errors!)
                        }else{
                            let errors = Mapper<ResponseError>().map(JSONString: "")
                            self.delegate?.onLoginFail(error: errors!)
                        }
                    
                }
        }
    }
}

///Authentication delegation to handle various events
protocol AuthenticationServiceDelegate {
    func onLoginFail(error: ResponseError)
    func onLoginSuccess(data: LoginModel)
}

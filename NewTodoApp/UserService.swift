//
//  UserService.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/16/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class UserService: BaseService {
    
    var delegate: UserServiceDelegation!
    
    override init() {
        super.init()
        let defaults = UserDefaults.standard
        self.baseHeader["Authorization"] = "Bearer " + defaults.string(forKey: defaultKeyStructure.accessToken)!
    
    
    }
    
    ///Function fetches the user data through API
    public func getUser() {
        Alamofire.request(self.getUrl(url: "user"), headers: self.baseHeader)
        .validate()
        .responseJSON(queue: self.queue) { response in
            
            if let data = response.data {
                switch response.result{
                case .success:
                    let json = String(data: data, encoding: .utf8)
                    let user = Mapper<User>().map(JSONString: json!)
                    self.setStatusCode(model: user!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.delegate?.onUserFetchSuccess(data: user!)
                    }
                    
                case .failure:
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    let errors = Mapper<ValidationError>().map(JSONString: json!)
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.delegate?.onUserFetchFail(errors: errors!)
                    }
                }
            }else{
                let errors = Mapper<BaseError>().map(JSONString: "")
                self.setStatusCode(model: errors!, response: response)
                
                //dispatching the content on main thread
                DispatchQueue.main.async {
                    self.delegate?.onFail(error: errors!)
                }
            }

        }
    }
    
    public func updateUser(user: [String:Any]) {
        
        
        Alamofire.request(self.getUrl(url: "user"), method: .patch, parameters: user, encoding: JSONEncoding.default, headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        let json = String(data: data, encoding: .utf8)
                        let user = Mapper<User>().map(JSONString: json!)
                        self.setStatusCode(model: user!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.delegate?.onUserFetchSuccess(data: user!)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        debugPrint(json!)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.delegate?.onUserFetchFail(errors: errors!)
                        }
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.delegate?.onFail(error: errors!)
                    }
                }
            }
    }
    
}


protocol UserServiceDelegation: BaseErrorDelegation {
    func onUserFetchSuccess(data: User)
    func onUserFetchFail(errors: ValidationError)
    func onUserUpdateSuccess(data: User)
    func onUserUpdateFail(errors: ValidationError)
}

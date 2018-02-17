//
//  TaskService.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/17/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class TaskService: BaseService {
    
    var delegate: TaskServiceDelegation!
    
    override init() {
        super.init()
        let defaults = UserDefaults.standard
        self.baseHeader["Authorization"] = "Bearer " + defaults.string(forKey: defaultKeyStructure.accessToken)!
    }
    
    ///Function fetches all tasks for the current logged in user
    public func getTasks() {
        Alamofire.request(self.getUrl(url: "tasks"), headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        let json = String(data: data, encoding: .utf8)
                        let tasks = Mapper<Tasks>().map(JSONString: json!)
                        self.setStatusCode(model: tasks!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.delegate?.onTasksFetchSuccess(data: tasks!)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.delegate?.onTasksFetchFail(errors: errors!)
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

protocol TaskServiceDelegation: TaskServiceFetchDelegation {
    
}

protocol TaskServiceFetchDelegation: BaseErrorDelegation{
    func onTasksFetchSuccess(data: Tasks)
    func onTasksFetchFail(errors: ValidationError)
}

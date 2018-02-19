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
    
    var addDelegation: TaskServiceAddDelegation!
    var fetchDelegation: TaskServiceFetchDelegation!
    var removeDelegation: TaskServiceDeleteDelegation!
    var editDelegation: TaskServiceEditDelegation!
    
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
                            self.fetchDelegation?.onTasksFetchSuccess(data: tasks!)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.fetchDelegation?.onTasksFetchFail(errors: errors!)
                        }
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.fetchDelegation?.onFail(error: errors!)
                    }
                }
            }
    }
    
    ///Function calls the api to add task
    /// - Parameter title: The title of the task
    /// - Parameter description: The descirption of the task
    public func addTask(title: String, description: String) {
        
        let params: Parameters = [
            "title" : title,
            "description": description
        ]
        
        Alamofire.request(self.getUrl(url: "tasks"), method:.post, parameters: params, encoding: JSONEncoding.default, headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        let json = String(data: data, encoding: .utf8)
                        let task = Mapper<CreateTask>().map(JSONString: json!)?.task
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.addDelegation?.onTaskAddSuccess(data: task!)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.addDelegation?.onTaskAddFail(errors: errors!)
                        }
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.addDelegation?.onFail(error: errors!)
                    }
                }
        }
    }
    
    ///Function calls api to delete task and delegates the action back to main thread with task id being deleted
    /// - Parameter taskId: Id of the task being removed
    public func removeTask(taskId: Int){
        Alamofire.request(self.getUrl(url: ("tasks/" + "\(taskId)")), method: .delete, headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.removeDelegation?.onTaskDeletedSucces(taskId: taskId)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.removeDelegation?.onTaskDeleteFail(errors: errors!)
                        }
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.removeDelegation?.onFail(error: errors!)
                    }
                }
        }
    }
    
    ///Update the task content through API
    /// - Parameter taskId: The task id of the task
    /// - Parameter title: The new title of the task
    /// - Parameter description: The new description of the task
    public func editTask(taskId: Int, title: String, description: String) {
        let params: Parameters = [
            "title": title,
            "description": description
        ]
        
        Alamofire.request(self.getUrl(url: ("tasks/" + "\(taskId)")), method: .patch, parameters: params, encoding: JSONEncoding.default, headers: self.baseHeader)
            .validate()
            .responseJSON(queue: self.queue){ response in
                if let data = response.data {
                    switch response.result{
                    case .success:
                        //dispatching the content on main thread
                        let json = String(data: data, encoding: .utf8)
                        let task = Mapper<EditTask>().map(JSONString: json!)?.task
                        DispatchQueue.main.async {
                            self.editDelegation?.onTaskEditSuccess(data: task!)
                        }
                        
                    case .failure:
                        let json = String(data: data, encoding: String.Encoding.utf8)
                        let errors = Mapper<ValidationError>().map(JSONString: json!)
                        self.setStatusCode(model: errors!, response: response)
                        
                        //dispatching the content on main thread
                        DispatchQueue.main.async {
                            self.editDelegation?.onTaskEditFail(errors: errors!)
                        }
                    }
                }else{
                    let errors = Mapper<BaseError>().map(JSONString: "")
                    self.setStatusCode(model: errors!, response: response)
                    
                    //dispatching the content on main thread
                    DispatchQueue.main.async {
                        self.editDelegation?.onFail(error: errors!)
                    }
                }
        }
    }
    
}

protocol TaskServiceFetchDelegation: BaseErrorDelegation{
    func onTasksFetchSuccess(data: Tasks)
    func onTasksFetchFail(errors: ValidationError)
}

protocol TaskServiceAddDelegation: BaseErrorDelegation {
    func onTaskAddSuccess(data: Task)
    func onTaskAddFail(errors: ValidationError)
}

protocol TaskServiceDeleteDelegation:BaseErrorDelegation {
    func onTaskDeletedSucces(taskId: Int)
    func onTaskDeleteFail(errors: ValidationError)
}

protocol TaskServiceEditDelegation: BaseErrorDelegation {
    func onTaskEditSuccess(data: Task)
    func onTaskEditFail(errors: ValidationError)
}

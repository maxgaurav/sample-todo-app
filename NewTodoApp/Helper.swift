//
//  Environment.swift
//  NewTodoApp
//
//  Created by Max Gaurav on 2/13/18.
//  Copyright © 2018 Max Gaurav. All rights reserved.
//

import Foundation

class Helper {
    
    
    public func getEnv(key: String, defaultValue: String = "") -> String {
        if let env = ProcessInfo.processInfo.environment[key] {
            return env
        }
        
        return defaultValue
    }
}

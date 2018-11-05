//
//  skill.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation

class Skill : NSObject
{
    var id: Int
    var level: Float
    var name: String
    
    override init() {
        self.id = 0
        self.level = 0.0
        self.name = ""
    }
    
    override var description: String {
        return "[\(id)] \(name) : \(level)"
    }
    
    func initWithDictionary(dictionary: NSDictionary)
    {
        if let id = dictionary["id"] as? Int {
            self.id = id
        }
        
        if let level = dictionary["level"] as? Float {
            self.level = level
        }
        
        if let name = dictionary["name"] as? String {
            self.name = name
        }
    }
    
}

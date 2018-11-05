//
//  project.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/19/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation

class Project : NSObject
{
    var id: Int             // done
    var name: String        // done
    var finalMark: Int      // done
    var cursusIds: [Int]    // done
    var parentId: Int?      // done
    var status: String      // done
    var validated: Bool     // done
    var childProject: [Project]
    
    var isSelected: Bool
    
    override init()
    {
        self.id = 0
        self.name = ""
        self.finalMark = 0
        self.cursusIds = [Int]()
        self.parentId = nil
        self.status = ""
        self.validated = false
        self.childProject = [Project]()
        
        self.isSelected = false
        
        super.init()
    }
    
    override var description: String {
        return "[\(id)] \(name) - mark \(finalMark) - status \(status) - validated ? \(validated)\nproject childs : \(childProject)"
    }
    
    func initWithDictionary(dictionary: NSDictionary)
    {
        self._readProjectCursusIds(dictionary: dictionary)
        self._readProjectDetails(dictionary: dictionary)
        self._readProjectDatas(dictionary: dictionary)
    }
    
    func isExpandable() -> Bool
    {
        if (self.childProject.count > 0) {
            return true
        }
        return false
        
    }
    
    /* PRIVATE */
    
    private func _readProjectDetails(dictionary: NSDictionary)
    {
        if let project = dictionary["project"] as? NSDictionary
        {
            if let id = project["id"] as? Int {
                self.id = id
            }
            
            if let name = project["name"] as? String {
                self.name = name
            }
            if let parent_id = project["parent_id"] as? Int {
                self.parentId = parent_id
            }
        }
    }
    
    private func _readProjectDatas(dictionary: NSDictionary)
    {
        if let final_mark = dictionary["final_mark"] as? Int {
            self.finalMark = final_mark
        }
        
        if let status = dictionary["status"] as? String {
            self.status = status
        }
        
        if let validated = dictionary["validated?"] as? Bool {
            self.validated = validated
        }
    }
    
    private func _readProjectCursusIds(dictionary: NSDictionary)
    {
        if let cursus_ids = dictionary["cursus_ids"] as? NSArray {
            for elem in cursus_ids {
                if let id = elem as? Int {
                    self.cursusIds.append(id)
                }
            }
        }
    }
}

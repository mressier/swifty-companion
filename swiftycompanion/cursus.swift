//
//  cursus.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation
import UIKit

class Cursus : NSObject
{
    var id: Int
    var name: String
    var level: Float
    var skills: [Skill]
    var projects: [Project]
    
    override init()
    {
        self.id = 0
        self.name = ""
        self.level = 0.0
        self.skills = [Skill]()
        self.projects = [Project]()
        
        super.init()
    }
    
    override var description: String {
        return "[\(id)] \(name) - lvl \(level) - skills : \(skills) - projects : \(projects)"
    }
    
    func initwithDictionary(dictionary: NSDictionary)
    {
        self._readCursusDetails(dictionary: dictionary)
        self._readCursusSkills(dictionary: dictionary)
    }
    
    func initProjectsForCursusWithProjectArray(array: NSArray)
    {
        var allProjects = self._getAllProjectsForCursus(array: array)
        allProjects = self._setAllChildProjects(allProjects: allProjects)
        self.projects = allProjects
    }
    
    /* private */
    
    private func _getAllProjectsForCursus(array: NSArray) -> [Project]
    {
        var allProjects = [Project]()
        for elem in array
        {
            let oneProject: Project = Project()
            
            if let dic = elem as? NSDictionary
            {
                oneProject.initWithDictionary(dictionary: dic)
                if oneProject.cursusIds.filter({ $0 == self.id }).count != 0 {
                    allProjects.append(oneProject)
                }
            }
        }
        return allProjects
    }
    
    private func _setAllChildProjects(allProjects: [Project]) -> [Project]
    {
        /* sort project */
        let allProjects = allProjects.sorted {
            project_1, project_2 in
            return (project_1.name.caseInsensitiveCompare(project_2.name) == ComparisonResult.orderedAscending)
        }
        
        var allNewProjects = allProjects
        
        /* set child projects */
        for (index, project) in allProjects.enumerated()
        {
            let childProject = allProjects.filter({ $0.parentId != nil && $0.parentId! == project.id })
            allNewProjects[index].childProject = childProject
        }
        allNewProjects = allNewProjects.filter({ $0.parentId == nil })
        return allNewProjects
    }
    
    private func _readCursusDetails(dictionary: NSDictionary)
    {
        if let cursus_id = dictionary["cursus_id"] as? Int {
            self.id = cursus_id
        }
        
        if let cursus_details = dictionary["cursus"] as? NSDictionary {
            if let name = cursus_details["name"] as? String {
                self.name = name
            }
        }
        
        if let level = dictionary["level"] as? Float {
            self.level = level
        }
    }
    
    private func _readCursusSkills(dictionary: NSDictionary)
    {
        if let skills = dictionary["skills"] as? NSArray
        {
            for elem in skills
            {
                if let one_skill = elem as? NSDictionary
                {
                    let skill:Skill = Skill()
                    skill.initWithDictionary(dictionary: one_skill)
                    self.skills.append(skill)
                }
            }
        }
    }
}


//
//  user.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation

class User : NSObject
{
    var login: String       // done
    var firstName: String   // done
    var lastName: String    // done
    var email: String       // done
    var phone: String       // done
    
    var imageURL: String    // done
    var location: String    // done
    var wallet: Int         // done
    var correctionPt: Int   // done
    
    var cursus:[Cursus]     // done
    
    override init()
    {
        self.login = ""
        self.firstName = ""
        self.lastName = ""
        self.email = ""
        self.phone = ""
        
        self.imageURL = ""
        self.location = "unavailable"
        self.wallet = 0
        self.correctionPt = 0

        self.cursus = [Cursus]()
        
        super.init()
    }
    
    override var description: String {
        return "\(login) - \(firstName) \(lastName)\n"
                + "mail : \(email), phone : \(phone)\n"
                + "location : \(location), wallet : \(wallet), correction point : \(correctionPt)\n"
                + "image: \(imageURL)\n"
                + "cursus : \(cursus)"
    }
    
    func initWithDictionnary(dictionary: NSDictionary)
    {
        self._readUserNames(dictionary: dictionary)
        self._readContactsDatas(dictionary: dictionary)
        self._readUserDetails(dictionary: dictionary)
        self._readUserCursus(dictionary: dictionary)
    }
    
    /* PRIVATE */
    
    private func _readContactsDatas(dictionary: NSDictionary)
    {
        if let email = dictionary["email"] as? String {
            self.email = email
        }
        
        if let phone = dictionary["phone"] as? String {
            self.phone = phone
        }
    }
    
    private func _readUserNames(dictionary: NSDictionary)
    {
        if let firstName = dictionary["first_name"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary["last_name"] as? String {
            self.lastName = lastName
        }
        
        if let login = dictionary["login"] as? String {
            self.login = login
        }
    }
    
    private func _readUserDetails(dictionary: NSDictionary)
    {
        if let imageURL = dictionary["image_url"] as? String {
            self.imageURL = imageURL
        }
        
        if let location = dictionary["location"] as? String {
            self.location = location
        }
        
        if let wallet = dictionary["wallet"] as? Int {
            self.wallet = wallet
        }
        
        if let correctionPt = dictionary["correction_point"] as? Int {
            self.correctionPt = correctionPt
        }
    }
    
    private func _readUserCursus(dictionary: NSDictionary)
    {
        if let cursus_users = dictionary["cursus_users"] as? NSArray
        {
            for cursus in cursus_users {
                if let dic = cursus as? NSDictionary
                {
                    let curs:Cursus = Cursus()
                    curs.initwithDictionary(dictionary: dic)
                    if let projects = self._readUserProjects(dictionary: dictionary) {
                        curs.initProjectsForCursusWithProjectArray(array: projects)
                    }
                    self.cursus.append(curs)
                }
            }
        }
    }
    
    private func _readUserProjects(dictionary: NSDictionary) -> NSArray?
    {
        if let projects_users = dictionary["projects_users"] as? NSArray {
            return projects_users
        }
        return nil
    }
}

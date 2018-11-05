//
//  ProfileTabBarViewController.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit

class ProfileTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    var  user:User? {
        didSet {
            print("set user on tab bar controller")
        }
    }
    
    var selectedCursusIndex: Int = 0 {
        didSet {
            print ("change view to : " + String(selectedCursusIndex))
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        for view in self.viewControllers! {
            view.navigationController?.navigationItem.title = user?.login
        }
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

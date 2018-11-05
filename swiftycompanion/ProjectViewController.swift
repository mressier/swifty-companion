//
//  ProjectTableViewController.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/19/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var user: User { return self.parentTabBar.user! }
    var selectedCursusIndex: Int {
        return self.parentTabBar.selectedCursusIndex
    }
    
    var parentTabBar: ProfileTabBarViewController {
        return self.tabBarController! as! ProfileTabBarViewController
    }
    
    var projects: [Project]? {
        return self.parentTabBar.user?.cursus[self.selectedCursusIndex].projects
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        self.parentTabBar.selectedCursusIndex = sender.selectedSegmentIndex
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let projects = self.projects {
            var count: Int = 0
            
            for project in projects
            {
                if (project.isSelected) {
                    count += project.childProject.count
                }
                count += 1
            }
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ProjectViewCell = ProjectViewCell()
        
        if let (project, is_child) = getProjectForIndex(index: indexPath.row)
        {
            if (is_child == false) {
                cell = self.tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectViewCell
            }
            else {
                cell = self.tableView.dequeueReusableCell(withIdentifier: "childProjectCell") as! ProjectViewCell
            }
            cell.project = project
            cell.isUserInteractionEnabled = project.isExpandable() ? true : false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let (project, is_child) = getProjectForIndex(index: indexPath.row)
        {
            /* select or deselect project */
            if is_child == false && project.isExpandable()
            {
                if project.isSelected == true {
                    project.isSelected = false
                }
                else {
                    project.isSelected = true
                }
                self.tableView.reloadData()
            }
        }
    }

    /* return (project, is_child) */
    func getProjectForIndex(index: Int) -> (Project, Bool)?
    {
        var count: Int = 0
        
        if let projects = self.projects
        {
            for project in projects
            {
                if (count == index) {
                    return (project, false)
                }
                count += 1
                
                if (project.isSelected == true && project.childProject.count > 0)
                {
                    for childProject in project.childProject
                    {
                        if (count == index) {
                            return (childProject, true)
                        }
                        count += 1
                    }
                }
            }
        }
        return nil
    }
    
    /* load */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = intraBlue
        setSegmentedControlBar(segmentControl: self.segmentControl, user: self.user)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.segmentControl.selectedSegmentIndex = self.selectedCursusIndex
        self.tableView?.reloadData()
    }

}

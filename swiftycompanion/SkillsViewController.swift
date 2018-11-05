//
//  SkillsViewController.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit

class SkillsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var user: User { return self.parentTabBar.user! }
    var selectedCursusIndex: Int {
            return self.parentTabBar.selectedCursusIndex
    }
    
    var parentTabBar: ProfileTabBarViewController {
        return self.tabBarController! as! ProfileTabBarViewController
    }
    
    var skills: [Skill]? {
        return self.user.cursus[self.selectedCursusIndex].skills
    }
    
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func segmentControlChanged(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        self.parentTabBar.selectedCursusIndex = sender.selectedSegmentIndex
        self.skillsTableView.reloadData()
    }
    
    /* table view cells */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.user.cursus.count > 0 && self.skills != nil {
            return self.skills!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillCell") as! SkillViewCell
        cell.skill = self.skills?[indexPath.row]
        return cell
    }
    
    /* load */
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.skillsTableView.separatorColor = intraBlue
        setSegmentedControlBar(segmentControl: self.segmentControl, user: self.user)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.segmentControl.selectedSegmentIndex = self.selectedCursusIndex
        self.skillsTableView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

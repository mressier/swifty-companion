//
//  ProfileViewController.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController, UIScrollViewDelegate {

    var user:User { return self.parentTabBar.user! }
    var selectedCursusIndex: Int {
            return self.parentTabBar.selectedCursusIndex
    }
    
    var parentTabBar: ProfileTabBarViewController {
        return self.tabBarController! as! ProfileTabBarViewController
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var wallets: UILabel!
    @IBOutlet weak var correctionPt: UILabel!
    
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func segmentControlChange(_ sender: UISegmentedControl) {
        self.parentTabBar.selectedCursusIndex = sender.selectedSegmentIndex
        self._setDatasFromCursus()
    }
    
    /* load */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.login.text? = self.user.login
        self.name.text? = self.user.firstName + " " + self.user.lastName
        self.phone.text? = (self.user.phone == "") ? "no phone" : self.user.phone
        self.location.text? = self.user.location
        self.wallets.text? = String(self.user.wallet) + " ₳"
        self.correctionPt.text? = String(self.user.correctionPt) + "pts"
        
        /* image */
        self.userImage.sd_setShowActivityIndicatorView(true)
        self.userImage.sd_setIndicatorStyle(.gray)
        self.userImage.sd_setImage(with: URL(string: self.user.imageURL), placeholderImage: #imageLiteral(resourceName: "default_user"));
        
        setSegmentedControlBar(segmentControl: self.segmentControl, user: self.user)
        
        self._setDatasFromCursus()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.segmentControl.selectedSegmentIndex = self.selectedCursusIndex
        self._setDatasFromCursus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func _setDatasFromCursus()
    {
        /* level */
        if self.user.cursus.count > 0
        {
            let level: Float = self.user.cursus[self.selectedCursusIndex].level
            self.level.text? = String(level) + "%"
        
            self.progressBar.setProgress(level - Float(Int(level)), animated: true)
        }
    }
    
    /* private */
}

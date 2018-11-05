//
//  ViewController.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/16/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit
import SwiftyGif

class WelcomeViewController: UIViewController, API42RequestDelegate {

    var user: User?
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchB: UIButton!
    @IBOutlet weak var bgView: UIImageView!
    
    @IBAction func searchButton(_ sender: Any)
    {
//        self.APIrequest?.token = "toto"
        if let search = searchField.text {
            let trim = search.trimmingCharacters(in: CharacterSet.whitespaces)
            if (trim != "")
            {
                if let pseudo = trim.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
                    
                    self.activityIndicator.startAnimating()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
                    self.activityIndicator.isHidden = false
                    self.searchB.isUserInteractionEnabled = false
                    self.APIrequest?.getUser(login: pseudo)
                }
            }
        }
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.searchField.text? = ""
    }
    
    /* API */
    
    var APIrequest: API42Request?
    
    func requestSuccess(response: Any)
    {
        DispatchQueue.main.async
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.searchB.isUserInteractionEnabled = true
            if let user = response as? User
            {
                self.user = user
                self.performSegue(withIdentifier: "segueToProfile", sender: nil)
            }
        }
    }
    
    func requestFailed(error: String)
    {
        DispatchQueue.main.async
        {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.searchB.isUserInteractionEnabled = true
            popAlert(view: self, message: error)
            print(error)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.user = nil
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.APIrequest = API42Request(delegate: self)
        
        /* background */
        let gifmanager = SwiftyGifManager(memoryLimit:20)
        let gif = UIImage(gifName: "42-bg.gif", levelOfIntegrity:0.5)
        self.bgView.setGifImage(gif, manager: gifmanager)

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /* navigation */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToProfile"
        {
            if let dest = segue.destination as? ProfileTabBarViewController
            {
                dest.user = self.user
            }
        }
    }

}


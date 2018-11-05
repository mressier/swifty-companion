//
//  popAlert.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation
import UIKit

func popAlert(view: UIViewController, message: String)
{
    let alert = UIAlertController(title: "Swifty Companion", message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    view.present(alert, animated: true, completion: nil)
}

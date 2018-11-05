//
//  segmentedControlBar.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import Foundation
import UIKit

func setSegmentedControlBar(segmentControl : UISegmentedControl, user: User)
{
    if user.cursus.count == 0 {
        segmentControl.isHidden = true
        return ;
    }
    
    /* segment control */
    segmentControl.isHidden = false
    segmentControl.removeAllSegments()
    for (index, elem) in user.cursus.enumerated()
    {
        segmentControl.insertSegment(withTitle: elem.name, at: index, animated: true)
    }
    segmentControl.selectedSegmentIndex = 0
}


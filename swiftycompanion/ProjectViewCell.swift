//
//  ProjectViewCell.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/19/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit

class ProjectViewCell: UITableViewCell {

    var project: Project? {
        didSet {
            if let project = self.project {
                self.nameLabel.text? = project.name
                
                self._setFinalMark(project: project, toSet: self.markLabel)

                /* child projects */
                if (project.isExpandable() == false) {
                    self.expandLabel.isHidden = true;
                }
                else {
                    self.expandLabel.isHidden = false;
                    if (project.isSelected) {
                        self.expandLabel.text = "reduce"
                    }
                    else {
                        self.expandLabel.text = "view more"
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var expandLabel: UILabel!

    private func _setFinalMark(project: Project, toSet: UILabel)
    {
        /* final mark */
        if (project.status == "finished")
        {
            toSet.text? = String(project.finalMark)
            
            if (project.validated == true && project.finalMark > 0) {
                toSet.textColor = intraGreen
            }
            else {
                toSet.textColor = intraRed
            }
        }
        else
        {
            toSet.text? = "in progress"
            toSet.textColor = UIColor.gray
        }
    }

}

//
//  ProjectCell.swift
//  swiftycompanion
//
//  Created by Mathilde RESSIER on 10/18/17.
//  Copyright © 2017 Mathilde RESSIER. All rights reserved.
//

import UIKit

class SkillViewCell: UITableViewCell {

    var skill:Skill? {
        didSet {
            if let skill = self.skill {
                self.nameLabel.text? = skill.name
                self.levelLabel.text? = String(skill.level) + "%"
                self.progressBar.setProgress(Float(skill.level / 20), animated: true)
                self._setProgressBarColor(level: skill.level)
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var levelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func _setProgressBarColor(level: Float)
    {
        if level < 5.0 {
            self.progressBar.progressTintColor = intraRed
            self.levelLabel.tintColor = intraRed
        }
        else if level < 10.0 {
            self.progressBar.progressTintColor = intraYellow
            self.levelLabel.tintColor = intraYellow
        }
        else if level < 15.0 {
            self.progressBar.progressTintColor = intraGreen
            self.levelLabel.tintColor = intraGreen
        }
        else {
            self.progressBar.progressTintColor = intraSuperGreen
            self.levelLabel.tintColor = intraSuperGreen
        }
    }

}

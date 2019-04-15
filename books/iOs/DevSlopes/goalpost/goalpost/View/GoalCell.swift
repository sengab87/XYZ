//
//  GoalCell.swift
//  goalpost
//
//  Created by Ahmed Sengab on 12/24/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var completionView: UIView!
    @IBOutlet weak var goalProgressLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalDescLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configureCell(goal: Goal)
    {
        self.goalDescLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType
        self.goalProgressLbl.text = String(describing: goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue {
            self.completionView.isHidden = false
        }
        else {
            self.completionView.isHidden = true
        }
    }
}

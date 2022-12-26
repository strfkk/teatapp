//
//  ChatTableViewCell.swift
//  teatApp
//
//  Created by streifik on 08.12.2022.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var timeLabelToBubbleViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabelToContentviewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLabelLedingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!


    var lightBlueColor = UIColor(red: 0, green: 0.7137, blue: 1, alpha: 1.0) /* #00b6ff */
    var blueColor =     UIColor.blue
    var lightGrayColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.0)
    
    @IBOutlet weak var bubleBackgroundView: UIView!
    
    var isComing: Bool! {
        didSet {
            bubleBackgroundView.backgroundColor = isComing ? self.lightGrayColor : self.blueColor
            messageLabel.textColor = isComing ? .black : .white
            
            timeLabel.textColor = isComing ? .gray : self.lightGrayColor

            if (isComing == true){
                timeLabelToBubbleViewTrailingConstraint.isActive = true
                messageLabelLedingConstraint.isActive = true
                timeLabelToContentviewTrailingConstraint.isActive = false //
            } else {
                messageLabelLedingConstraint.isActive = false
                timeLabelToContentviewTrailingConstraint.isActive = true
                timeLabelToBubbleViewTrailingConstraint.isActive = false
            }
        }
    }
}

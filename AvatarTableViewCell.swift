//
//  AvatarTableViewCell.swift
//  teatApp
//
//  Created by streifik on 07.12.2022.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ProfileListTableViewCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/8/21.
//

import UIKit

class ProfileListTableViewCell: UITableViewCell {
    
    @IBOutlet var name: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

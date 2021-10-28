//
//  SantaLetterCell.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/24/21.
//

import UIKit

class SantaLetterCell: UITableViewCell {

    @IBOutlet var date: UILabel!
    @IBOutlet var message: UILabel!
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

//
//  customButton.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/28/21.
//

import Foundation
import UIKit

class customButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.layer.borderWidth = 1
        self.backgroundColor = UIColor(hex: Colors().buttonBackground)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 15,bottom: 10,right: 15)
        }
}

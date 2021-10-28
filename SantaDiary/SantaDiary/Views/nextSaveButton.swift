//
//  nextSaveButton.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/27/21.
//

import Foundation
import UIKit

class nextSaveButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.layer.borderWidth = 1
        self.backgroundColor = UIColor.red
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 10

        }
}

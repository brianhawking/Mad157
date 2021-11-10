//
//  4BoxPassword.swift
//  4BoxPassword
//
//  Created by Brian Veitch on 11/8/21.
//

import Foundation

class BoxPassword {
    
    var password = ""
    var maxBoxes = 0
    var currentBox = 1
    
    init(password: String) {
        self.password = password
        self.maxBoxes = password.count + 1
    }
}

//
//  ColorScheme.swift
//  SightWords
//
//  Created by Brian Veitch on 10/6/21.
//

import Foundation
import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

class ColorScheme {
    var styles:[Style] = []
    var index: Int = 0
    
    init() {
       
    }
    
    func save() {
        UserDefaults.standard.setValue(self.index, forKey: "ColorSchemeIndex")
    }
    
    func load() {
        index = UserDefaults.standard.integer(forKey: "ColorScheme")
    }
}

struct Style {
    var viewBackground: UIColor
    var cardBackground: UIColor
    var textColor: UIColor
    
    init(viewBackground: UIColor, cardBackground: UIColor, textColor: UIColor) {
        self.viewBackground = viewBackground
        self.cardBackground = cardBackground
        self.textColor = textColor
    }
}

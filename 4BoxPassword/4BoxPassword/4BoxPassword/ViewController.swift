//
//  ViewController.swift
//  4BoxPassword
//
//  Created by Brian Veitch on 11/8/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // password boxes
    @IBOutlet var boxes: [UILabel]!

    var currentBox = 1
    var maxBoxes = 4
    var password = "2222"
    var showNumbers = true
    
    @IBOutlet weak var hiddenTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set up boxes
        for box in boxes {
            // design your boxes
            box.backgroundColor = UIColor.white
            box.layer.borderColor = UIColor.black.cgColor
            box.layer.borderWidth = 2
            box.layer.cornerRadius = 20
            box.layer.masksToBounds = true
            box.text = " "
        }
        
        
        hiddenTextField.delegate = self
        
        // hide textfield
//        hiddenTextField.isHidden = true
        
        // set first responder
        hiddenTextField.becomeFirstResponder()
        
        
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        // note this code runs before it actually accepts the character
        // textfield is not the same as hiddentextfield
        
        // get textfield count, 0 if nill
        var characterCount = textField.text?.count ?? 0

        // character reached it's max, remove last entered character
        if(characterCount == (maxBoxes+1)) {
            textField.text?.removeLast()
            characterCount = textField.text!.count
        }
        
        // hasn't reached max, add digit to screen
        if (characterCount < maxBoxes+1 && currentBox <= characterCount ) {
            
            // add a character
            if(showNumbers) {
                boxes[characterCount-1].text = textField.text![characterCount-1]
            }
            else {
                boxes[characterCount-1].text = "X"
            }
            
            
            // haven't reached last box yet. Move to next box
            if (currentBox < maxBoxes) {
                currentBox += 1
            }
        }
        else {
            // last box reached
            // remove digit from box
            boxes[currentBox-1].text = " "
            
            // user deleted a box. only do this if there's a box to delete
            if (currentBox > 0) {
                currentBox -= 1
            }
        }
        
        // check if user entered password
        if (textField.text == password) {
            performSegue(withIdentifier: "toNextScreen", sender: nil)
        }
        
    }


}



extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}


//
//  PasswordViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/4/21.
//

import UIKit

class PasswordViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")

    var password = "2222"
    
    @IBOutlet weak var hiddenTextField: UITextField!
    
    @IBOutlet var digits: [UILabel]!
    var digit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        hiddenTextField.delegate = self
        hiddenTextField.becomeFirstResponder()
        hiddenTextField.isHidden = true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        // get text count, 0 if it's null
        var characterCount = textField.text?.count ?? 0
        
        print("digit: \(digit), count \(characterCount)")
        
        // character reached it's max
        if(characterCount == 5) {
            textField.text?.removeLast()
            characterCount = textField.text!.count
        }
        
        // hasn't reached max, add digit to screen
        if (characterCount < 5 && digit+1 <= characterCount ) {
            
            // add a character
            digits[characterCount-1].text = textField.text![characterCount - 1]
            
            if (digit < 3) {
                digit += 1
            }
        }
        else {
            
            // remove digit from box
            digits[digit].text = " "
            
            if (digit > 0) {
                digit -= 1
            }
        }
        
        print(textField.text)
        
        if (textField.text == password) {
            performSegue(withIdentifier: "toForParents", sender: nil)
        }
        
    }
}



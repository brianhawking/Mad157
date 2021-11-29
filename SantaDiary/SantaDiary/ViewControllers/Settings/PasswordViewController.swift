//
//  PasswordViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/4/21.
//

import UIKit

class PasswordViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())

    var password = "2222"
    
    @IBOutlet weak var hiddenTextField: UITextField!
    
    @IBOutlet var digits: [UILabel]!
    var digit = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("name: \(profileInformation.name)")
        
        hiddenTextField.delegate = self
        hiddenTextField.becomeFirstResponder()
        hiddenTextField.isHidden = true
        
        for box in digits {
            box.layer.cornerRadius = 10
        }
        
        profileInformation.image = ProfileManager().getProfileImage(profileName: profileInformation.name)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(contentsOfFile: profileInformation.image), style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toForParents") {
            let controller = segue.destination as! ForParentsViewController
            
            controller.profileInformation = profileInformation
        }
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
        
        if (textField.text == password) {
            performSegue(withIdentifier: "toForParents", sender: nil)
        }
        
    }
}



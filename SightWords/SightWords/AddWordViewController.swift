//
//  AddWordViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 9/17/21.
//

import UIKit

class AddWordViewController: UIViewController {

    public var completionHandler: ((String) -> Void)?
    
    @IBOutlet weak var newWordText: UITextField!
    
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for button in buttons {
            button.layer.borderWidth = 2
            button.backgroundColor = UIColor.red
            button.layer.cornerRadius = 10
            button.setTitleColor(.white, for: .normal)
            
        }
        
        newWordText.text = ""
        
    }
    

    @IBAction func saveAction(_ sender: UIButton) {
        
        if newWordText.text != "" {
            
            completionHandler?(newWordText.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newWordText.resignFirstResponder()
    
        return true
    }
    
    
}

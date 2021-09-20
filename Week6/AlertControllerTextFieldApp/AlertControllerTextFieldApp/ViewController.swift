//
//  ViewController.swift
//  AlertControllerTextFieldApp
//
//  Created by Brian Veitch on 9/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        labelResult.numberOfLines = 0
    }

    @IBAction func buttonTapped(_ sender: Any) {
        
        let alert = UIAlertController(title: "Log in", message: "Enter password", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textfield in
            textfield.placeholder = "Password here"
            textfield.isSecureTextEntry = true
        })
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            let savedText = alert.textFields![0] as UITextField
            self.labelResult.text = savedText.text
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


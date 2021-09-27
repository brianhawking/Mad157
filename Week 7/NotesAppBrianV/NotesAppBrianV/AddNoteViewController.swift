//
//  AddNoteViewController.swift
//  NotesAppBrianV
//
//  Created by Brian Veitch on 9/27/21.
//

import UIKit

class AddNoteViewController: UIViewController {

    
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    public var completionHandler: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        if titleTextField.text == "" || contentTextView.text == "" {
            print("Don't dismiss")
            return
        }
        
        // send data back
        if let title = titleTextField.text, let content = contentTextView.text {
            completionHandler?(title, content)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

}

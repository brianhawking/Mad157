//
//  EditNoteViewController.swift
//  NotesAppBrianV
//
//  Created by Brian Veitch on 9/27/21.
//

import UIKit

class EditNoteViewController: UIViewController {

    var titleText: String = ""
    var contentText: String = ""
    
    public var completionHandler: ((String, String) -> Void)?
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = titleText
        contentTextView.text = contentText
        
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        if let title = titleTextField.text, let content = contentTextView.text {
            completionHandler?(title, content)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    

}

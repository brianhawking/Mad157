//
//  ReminderController.swift
//  TabbedMiniAppBrianV
//
//  Created by Brian Veitch on 9/21/21.
//

import UIKit

class ReminderController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.setValue(UIColor.white, forKey: "textColor")
        
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        
        let whitePlaceholderText = NSAttributedString(string: "Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])

        titleTextField.attributedPlaceholder = whitePlaceholderText
        titleTextField.textColor = UIColor.white
        
        
        saveButton.backgroundColor = UIColor.gray
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.cornerRadius = saveButton.frame.height/2
        saveButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
    @IBAction func saveAction(_ sender: UIButton) {
        if titleTextField.text == "" {
            return
        }
        
        let selectedDate: String = dateFormatter.string(from: datePicker.date)
    
        
        let alert = UIAlertController(title: "Confirm Event", message: "\(titleTextField.text!) on \(selectedDate)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Confirm", style: .default, handler: { action -> Void in
            self.confirmEvent()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action -> Void in
        })

        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func confirmEvent() {
        print("CONFIRMED")
    }
    
}

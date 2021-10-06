//
//  AddWordViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 10/2/21.
//

import UIKit
import Foundation
import CoreData

class AddWordViewController: UIViewController {

    var dataManager: NSManagedObjectContext!
    
    
    @IBOutlet weak var addWordTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addWordTextField.text = ""
        addWordTextField.becomeFirstResponder()
        
        // data manager for core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        
        saveButton.backgroundColor = UIColor.red
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.layer.cornerRadius = 10

    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        if addWordTextField.text == "" {
            return
        }
        
        saveWord()
        
    }
    
    func saveWord() {
        
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Words", into: dataManager)
        newEntity.setValue(addWordTextField.text!, forKey: "word")
        
        do {
            try self.dataManager.save()
        }
        catch {
            print("Error saving data")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addWordTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addWordTextField.resignFirstResponder()
    }
    

}

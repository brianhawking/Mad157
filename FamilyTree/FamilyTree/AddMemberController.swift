//
//  AddMemberController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/12/21.
//

import UIKit

class AddMemberController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate {

    var addType: String = ""
    @IBOutlet weak var addTypeLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextView: UITextField!
    @IBOutlet weak var descriptionText: UITextView!
    
    // variables
    
    // name of current family member
    var name: String = ""
    var person: (name: String, id: Int) = (name: "", id: 0)
    
    // array of everyone!
    var persons: [Person] = []
    
    // array of everyone but filtered so you can't choose someone you already added
    var available: [Person] = []
    
    // id of newly added member
    var id: Int = -1
    
    
    @IBOutlet weak var tableView: UITableView!
        
    
    public var completionHandler: ((String, Int, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        nameTextView.delegate = self
        descriptionText.delegate = self
        addTypeLabel.text = "Add " + addType
        nameLabel.text = person.name
        descriptionText.layer.borderWidth = 1
        descriptionText.layer.borderColor = UIColor.gray.cgColor
    
        // remove members that already linked
        for (index, p) in persons.enumerated() {
            if persons[person.id].partner.contains(p.id) ||
                persons[person.id].children.contains(p.id) ||
                persons[person.id].parents.contains(p.id) ||
                persons[person.id].siblings.contains(p.id) ||
                person.id == p.id {
                
            }
            else {
                available.append(persons[index])
            }
        }
        available.sort{$0.name < $1.name}
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        nameTextView.text = available[indexPath.row].name
        descriptionText.text = available[indexPath.row].description
        id = available[indexPath.row].id
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return available.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell1", for: indexPath)
       
        cell.textLabel?.text = available[indexPath.row].name
        
        return cell
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        if nameTextView.text == "" {
            return
        }
        
        name = nameTextView.text!
        let description = descriptionText.text!
        
        completionHandler?(name, id, description)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//    }
//
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
//    {
//
//        let currentText:String = textView.text
//            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//            // If updated text view will be empty, add the placeholder
//            // and set the cursor to the beginning of the text view
//
//            if updatedText.isEmpty {
//
//                textView.text = "enter description (optional)"
//                textView.textColor = UIColor.lightGray
//
//                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//            }
//            else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//                  textView.textColor = UIColor.black
//                  textView.text = text
//              }
//
//        if(text == "\n")
//        {
//            view.endEditing(true)
//            return false
//        }
//        else
//        {
//            return true
//        }
//    }
    
}

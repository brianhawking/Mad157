//
//  AddMemberController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/12/21.
//

import UIKit

class AddMemberController: UIViewController {

    var addType: String = "Child"
    @IBOutlet weak var addTypeLabel: UILabel!
    
    @IBOutlet weak var nameTextView: UITextField!
    
    var name: String = ""
    
    var callback : ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addTypeLabel.text = "Add " + addType
    }
    

    @IBAction func saveAction(_ sender: Any) {
        name = nameTextView.text!
        print(name)
        callback!(name)
        dismiss(animated: true, completion: nil)
    }
    
}

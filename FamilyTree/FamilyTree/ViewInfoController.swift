//
//  ViewInfoController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/13/21.
//

import UIKit

class ViewInfoController: UIViewController {

    var name: String = ""
    var descriptionText: String = ""
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = name
        descriptionTextView.text = descriptionText
    }


    @IBAction func dismissAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

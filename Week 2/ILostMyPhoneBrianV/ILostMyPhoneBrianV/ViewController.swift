//
//  ViewController.swift
//  ILostMyPhoneBrianV
//
//  Created by Brian Veitch on 8/24/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var contactLabel: UILabel!
    
    var contactInfo: String = "Brian Veitch\nbeveitch@gmail.com\n1344 Fountain Green Drive\nCrystal Lake, IL\n(815) 404-0576"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getContactInfoAction(_ sender: Any) {
        contactLabel.text = contactInfo
    }
}


//
//  ViewController.swift
//  ILostMyPhoneBrianV
//
//  Created by Brian Veitch on 8/24/21.
//

import UIKit

class ViewController: UIViewController {
    
    var contactInfo: String = "Reach my owner at \nBrian Veitch\nbeveitch@gmail.com\n1344 Fountain Green Drive,\nCrystal Lake, 60014\n(815) 404-0576"

    @IBOutlet weak var contactLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func showContactInfoAction(_ sender: Any) {
        contactLabel.text = contactInfo
    }
    
}


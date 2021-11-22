//
//  BirthdayViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/22/21.
//

import UIKit

class BirthdayViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
    }
    


}

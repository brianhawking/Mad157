//
//  SettingsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/17/21.
//

import UIKit

class SettingsViewController: UIViewController {

    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
    }
    

}

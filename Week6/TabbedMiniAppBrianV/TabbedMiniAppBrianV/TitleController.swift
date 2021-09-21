//
//  TitleController.swift
//  TabbedMiniAppBrianV
//
//  Created by Brian Veitch on 9/21/21.
//

import UIKit

class TitleController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "toTabbedAppSegue", sender: nil)
    }
    
}

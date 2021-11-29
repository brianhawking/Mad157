//
//  LetterSetupViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/28/21.
//

import UIKit

class LetterSetupViewController: UIViewController {

    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())
    var from = "User"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func writeCustomButton(_ sender: Any) {
        performSegue(withIdentifier: "writeCustomSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "writeCustomSegue") {
            let controller = segue.destination as! WriteLetterViewController
            
            controller.profileInformation = profileInformation
            controller.from = "User"
        }
    }
}

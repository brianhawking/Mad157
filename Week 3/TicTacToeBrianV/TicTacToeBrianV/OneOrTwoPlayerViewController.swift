//
//  OneOrTwoPlayerViewController.swift
//  TicTacToeBrianV
//
//  Created by Brian Veitch on 9/10/21.
//

import UIKit

class OneOrTwoPlayerViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for button in buttons {
            button.layer.cornerRadius = 20
            button.layer.shadowColor   = UIColor.black.cgColor
            button.layer.shadowOffset  = CGSize(width: 0.0, height: 6.0)
            button.layer.shadowRadius  = 8
            button.layer.shadowOpacity = 0.5
            button.layer.masksToBounds = false
        }
    }

    @IBAction func TwoPlayerAction(_ sender: Any) {
        performSegue(withIdentifier: "twoPlayerSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "twoPlayerSegue") {
            print("Segue")
            let controller = segue.destination as! ViewController
            controller.onePlayer = false
        }
    }
    
}

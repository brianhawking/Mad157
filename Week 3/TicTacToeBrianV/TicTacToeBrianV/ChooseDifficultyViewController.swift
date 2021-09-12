//
//  ChooseDifficultyViewController.swift
//  TicTacToeBrianV
//
//  Created by Brian Veitch on 9/10/21.
//

import UIKit

class ChooseDifficultyViewController: UIViewController {

    var difficulty: String = "Easy"
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
    

    @IBAction func chooseDifficultyAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            difficulty = "Easy"
        }
        else if sender.tag == 2 {
            difficulty = "Medium"
        }
        else {
            difficulty = "Impossible"
        }
        
        performSegue(withIdentifier: "toSelectionSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ChoosePieceViewController
        controller.difficulty = difficulty
       
    }
    
}

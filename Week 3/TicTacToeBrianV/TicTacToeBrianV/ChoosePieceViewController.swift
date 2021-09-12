//
//  ChoosePieceViewController.swift
//  TicTacToeBrianV
//
//  Created by Brian Veitch on 9/10/21.
//

import UIKit

class ChoosePieceViewController: UIViewController {

    var choosePiece: String = "meateater"
    var difficulty: String = "Easy"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePieceAction(_ sender: UIButton) {
        if sender.tag == 1 {
            choosePiece = "meateater"
        }
        else {
            choosePiece = "planteater"
        }
        performSegue(withIdentifier: "choosePieceSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! ViewController
        controller.onePlayer = true
        controller.difficulty = difficulty
        if choosePiece == "meateater" {
            controller.piece = "meateater"
        }
        else {
            controller.piece = "planteater"
        }
    }
    
}

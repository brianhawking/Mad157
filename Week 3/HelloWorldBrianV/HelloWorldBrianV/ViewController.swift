//
//  ViewController.swift
//  HelloWorldBrianV
//
//  Created by Brian Veitch on 8/24/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var textMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func changeButton(_ sender: UIButton) {
        labelResult.text = textMessage.text?.uppercased()
    }
    
}


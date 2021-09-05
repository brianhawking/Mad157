//
//  ViewController.swift
//  HelloWorldBrianV
//
//  Created by Brian Veitch on 8/24/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var textDisplay: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: Methods
    @IBAction func changeButton(_ sender: UIButton) {
        labelResult.text = textDisplay.text?.uppercased()
    }
    
}


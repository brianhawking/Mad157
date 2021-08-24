//
//  ViewController.swift
//  HelloWorldBrianV
//
//  Created by Brian Veitch on 8/22/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
    }

    @IBAction func Button(_ sender: Any) {
        if view.backgroundColor == UIColor.black {
            view.backgroundColor = UIColor.white
        }
        else {
            view.backgroundColor = UIColor.green
        }
        
        
    }
    
}


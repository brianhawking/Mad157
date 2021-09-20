//
//  ViewController.swift
//  TabBarMethodsApp
//
//  Created by Brian Veitch on 9/19/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add", message: "Add button tapped", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            //Just dismiss the action sheet
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    
}


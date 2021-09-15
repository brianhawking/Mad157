//
//  TitleViewController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/14/21.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.moveToMain()
        }
    }
    
    func moveToMain() {
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
}

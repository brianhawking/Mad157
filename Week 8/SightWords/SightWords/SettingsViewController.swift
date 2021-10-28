//
//  SettingsViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 10/14/21.
//

import UIKit

class SettingsViewController: UIViewController {

    // color scheme
    var colors = ColorScheme()
    
    @IBOutlet var switches: [UISwitch]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // set color scheme
        colors.load()
        view.backgroundColor = colors.styles[colors.index].viewBackground
        
        updateSwitches()
    }
    
    func updateSwitches() {
        for s in switches {
            s.isOn = UserDefaults.standard.bool(forKey: String(s.tag))
        }
    }

    @IBAction func letterSwitch(_ sender: UISwitch) {
        
        UserDefaults.standard.setValue(sender.isOn, forKey: String(sender.tag))
    }
    
}

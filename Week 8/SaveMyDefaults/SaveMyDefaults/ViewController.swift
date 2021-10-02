//
//  ViewController.swift
//  SaveMyDefaults
//
//  Created by Brian Veitch on 10/2/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mySerialNumber: UITextField!
    
    @IBOutlet weak var mySlider: UISlider!
    
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func mySaveButton(_ sender: UIButton) {
        UserDefaults.standard.set(mySerialNumber.text, forKey: "serialNumber")
        UserDefaults.standard.set(mySlider.value, forKey: "Slider")
        UserDefaults.standard.set(mySwitch.isOn, forKey: "Switch")
    }
    
    
    @IBAction func myLoadButton(_ sender: UIButton) {
        mySwitch.isOn = UserDefaults.standard.bool(forKey: "Switch")
        mySlider.value = UserDefaults.standard.float(forKey: "Slider")
        mySerialNumber.text = UserDefaults.standard.string(forKey: "serialNumber")
    }
    
    
    @IBAction func myDeleteButton(_ sender: UIButton) {
        mySwitch.isOn = true
        mySlider.value = 0.5
        mySerialNumber.text = ""
    }
    
    
    

}


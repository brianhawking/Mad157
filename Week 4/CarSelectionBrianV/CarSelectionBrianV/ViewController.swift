//
//  ViewController.swift
//  CarSelectionBrianV
//
//  Created by Brian Veitch on 9/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: properties
    
    var carCost = 26949
    var carColor = "blue"
    var carUpholstry = "light"
    var carRims = "steel"

    
    var accessories: [(name: String, added: Bool, cost: Int)] = [
        (name: "charger", added: false, cost: 292),
        (name: "auto-dimming-mirror", added: false, cost: 365),
        (name: "sunshade", added: false, cost: 90),
        (name: "rear-gate-trim", added: false, cost: 213),
        (name: "sport-grille", added: false, cost: 459),
        (name: "console-protector", added: false, cost: 50),
        (name: "bike-carrier", added: false, cost: 430),
        (name: "bumper-guards", added: false, cost: 300),
        (name: "interior-trim-kit", added: false, cost: 322),
        (name: "cargo-carrier", added: false, cost: 520),
        (name: "pet-kennel", added: false, cost: 180),
        (name: "trailer-hitch", added: false, cost: 550)
    ]
    
    
    @IBOutlet weak var carCostLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    
    // outlet collections
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet var upholstryButtons: [UIButton]!
    @IBOutlet var rimButtons: [UIButton]!
    
    
    // images for mainImage
    var images: [String] = [
        "blue",
        "green",
        "black",
        "silver",
        "gray",
        "light",
        "dark"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        for button in colorButtons {
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.white.cgColor
        }
        colorButtons[0].layer.borderWidth = 0
        
        for accessory in accessories {
            images.append(accessory.name)
        }
        
    }
    
    

    @IBAction func selectColorAction(_ sender: UIButton) {
        mainImage.image = UIImage(named: images[sender.tag])
        for button in colorButtons {
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.white.cgColor
        }
        sender.layer.borderWidth = 0
    }
    
    
    @IBAction func selectUpholstryAction(_ sender: UIButton) {
        mainImage.image = UIImage(named: images[sender.tag])
        
        for button in upholstryButtons {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 2
    }
    
    @IBAction func selectRimAction(_ sender: UIButton) {
        for button in rimButtons {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 2
    }
    
    
    @IBAction func addAccessoryAction(_ sender: UIButton) {
        mainImage.image = UIImage(named: images[sender.tag])
        
        if (accessories[sender.tag-7].added == true) {
            accessories[sender.tag-7].added = false
            carCost -= accessories[sender.tag-7].cost
            sender.layer.borderWidth = 0
            print("removed")
        }
        else {
            accessories[sender.tag-7].added = true
            sender.layer.borderWidth = 2
            carCost += accessories[sender.tag-7].cost
            print("added")
        }
        
        updateCarCost()
    }
    
    func updateCarCost() {
        carCostLabel.text = "Total Cost: $\(carCost)"
    }
    
}


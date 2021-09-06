//
//  ViewController.swift
//  CarSelectionBrianV
//
//  Created by Brian Veitch on 9/5/21.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: properties
    
    // default values for car
    var carCost = 26949
    var carColor = "blue"
    var carUpholstry = "light"
    var carRims = "steel"

    // add accessories to accessory array
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
    
        // set borders to 5 (makes all buttons look smaller)
        for button in colorButtons {
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        // set border to 0. Makes the color button look bigger
        colorButtons[0].layer.borderWidth = 0
        
        // add accessories to images array
        for accessory in accessories {
            images.append(accessory.name)
        }
        
    }
    
    

    @IBAction func selectColorAction(_ sender: UIButton) {
        
        // change main image to show new car color
        mainImage.image = UIImage(named: images[sender.tag])
        carColor = images[sender.tag]
        
        // make all color buttons same size
        for button in colorButtons {
            button.layer.borderWidth = 5
            button.layer.borderColor = UIColor.white.cgColor
        }
        
        // makes current color button appear bigger
        sender.layer.borderWidth = 0
        
        updateCarCost()
    }
    
    
    @IBAction func selectUpholstryAction(_ sender: UIButton) {
        
        // change main image to show upholstry
        mainImage.image = UIImage(named: images[sender.tag])
        carUpholstry = images[sender.tag]
        
        // remove borders
        for button in upholstryButtons {
            button.layer.borderWidth = 0
        }
        
        // add border on selected upholstry
        sender.layer.borderWidth = 2
        
        updateCarCost()
    }
    
    @IBAction func selectRimAction(_ sender: UIButton) {
        
        // select the rim style
        if sender.tag == 100 {
            carRims = "steel"
        }
        else {
            carRims = "alloy"
        }
        for button in rimButtons {
            button.layer.borderWidth = 0
        }
        sender.layer.borderWidth = 2
        
        updateCarCost()
    }
    
    
    @IBAction func addAccessoryAction(_ sender: UIButton) { 
        
        // change main image to show accessory image
        mainImage.image = UIImage(named: images[sender.tag])
        
        // remove accessory from cart, if already selected
        if (accessories[sender.tag-7].added == true) {
            accessories[sender.tag-7].added = false
            carCost -= accessories[sender.tag-7].cost
            sender.layer.borderWidth = 0
        }
        else {
            accessories[sender.tag-7].added = true
            sender.layer.borderWidth = 2
            carCost += accessories[sender.tag-7].cost
        }
        
        updateCarCost()
    }
    
    func updateCarCost() {
        carCostLabel.text = "Total Cost: $\(carCost)"
        
        // output
        print("==================================")
        print("==================================")
        print("Car Details")
        print("Car Cost: \(carCost)")
        print("Car Color: \(carColor)")
        print("Upholstry: \(carUpholstry)")
        print("Rims: \(carRims)")
        print("Accessories")
        print("---------------------")
        for accessory in accessories {
            if accessory.added == true {
                print(accessory.name, accessory.cost)
            }
        }
    }
    
}


//
//  NiceOrNaughty.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/9/21.
//

import UIKit

class NiceOrNaughty: UIViewController {
    
    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")

    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var NiceNaughtyImage: UIImageView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var feedbackView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileName.text = "\(profileInformation.name), \(profileInformation.age)"
        
        feedbackView.layer.cornerRadius = 20
        feedbackView.layer.borderWidth = 2
    }
    


}

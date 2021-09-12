//
//  ProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/8/21.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")
   
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet var ButtonViews: [UIView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileNameLabel.text = profileInformation.name
        profileImage.image = UIImage(named: profileInformation.image)
        
        for buttonView in ButtonViews {
            buttonView.layer.cornerRadius = 20
            buttonView.layer.borderWidth = 2
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            
            buttonView.isUserInteractionEnabled = true
                buttonView.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        switch tag {
        case 1:
            performSegue(withIdentifier: "ToNiceNaughtySegue", sender: nil)
        case 2:
            print("You chose Send a letter")
        case 3:
            print("You chose diary")
        case 4:
            print("you chose mailbox")
        
        default:
            print("not sure what happened")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToNiceNaughtySegue") {
            let controller = segue.destination as! NiceOrNaughty
            controller.profileInformation = profileInformation
        }
    }

}

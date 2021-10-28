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

        // set title
//        self.title = profileInformation.name
        
        profileNameLabel.text = profileInformation.name
        profileImage.image = UIImage(named: profileInformation.image)
        
        for buttonView in ButtonViews {
            buttonView.layer.cornerRadius = 20
            buttonView.layer.borderWidth = 2
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            
            buttonView.isUserInteractionEnabled = true
                buttonView.addGestureRecognizer(gesture)
        }
        
        // edit navigation bar
        navigationController?.navigationBar.tintColor = UIColor.white;
        
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func handleTapGesture(sender: UITapGestureRecognizer) {
        let tag = sender.view!.tag
        
        switch tag {
        case 1:
            performSegue(withIdentifier: "ToNiceNaughtySegue", sender: nil)
        case 2:
            performSegue(withIdentifier: "toSantaLetters", sender: nil)
        case 3:
            performSegue(withIdentifier: "toDiary", sender: nil)
        case 4:
            performSegue(withIdentifier: "toMailbox", sender: nil)
        
        default:
            print("not sure what happened")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ToNiceNaughtySegue") {
            let controller = segue.destination as! NiceOrNaughty
            controller.profileInformation = profileInformation
        }
        else if (segue.identifier == "toDiary") {
            let controller = segue.destination as! DiaryViewController
            controller.profileInformation = profileInformation
        }
        else if (segue.identifier == "toMailbox") {
            let controller = segue.destination as! MailboxViewController
            controller.profileInformation = profileInformation
        }
        else if (segue.identifier == "toSantaLetters") {
            let controller = segue.destination as! LettersToSantaViewController
            controller.profileInformation = profileInformation
        }
        else if (segue.identifier == "toSettings") {
            let controller = segue.destination as! SettingsViewController
            controller.profileInformation = profileInformation
        }
    }

    @IBAction func settingsAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
}

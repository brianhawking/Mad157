//
//  ProfileViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/8/21.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())
   
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet var ButtonViews: [UIView]!
    
    @IBOutlet weak var mailboxNewCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileNameLabel.text = profileInformation.name
        profileImage.image = UIImage(contentsOfFile: ProfileManager().getProfileImage(profileName: profileInformation.name))
        
//        profileImage.layer.cornerRadius = profileImage.layer.frame.height/2
//        profileImage.clipsToBounds = true
//        profileImage.layer.borderWidth = 3
//        profileImage.layer.borderColor = UIColor.black.cgColor
        
        
        
        mailboxNewCountLabel.layer.cornerRadius = mailboxNewCountLabel.layer.frame.height/2
        mailboxNewCountLabel.layer.borderWidth = 3
        mailboxNewCountLabel.layer.borderColor = UIColor.yellow.cgColor
        mailboxNewCountLabel.layer.masksToBounds = true
        
        if(LetterManager().getLettersCount(profileName: profileInformation.name) > 0) {
           
            mailboxNewCountLabel.text = "  \(LetterManager().getLettersCount(profileName: profileInformation.name))  "
        }
        else {
            mailboxNewCountLabel.isHidden = true
        }
        
        
        
        for buttonView in ButtonViews {
            buttonView.layer.cornerRadius = 20
            buttonView.layer.borderWidth = 2
            buttonView.layer.masksToBounds = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
            
            buttonView.isUserInteractionEnabled = true
                buttonView.addGestureRecognizer(gesture)
        }
        
        // edit navigation bar
        navigationController?.navigationBar.tintColor = UIColor.white;
        
        navigationController?.navigationBar.prefersLargeTitles = true

        self.title = profileInformation.name
        profileNameLabel.isHidden = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Noteworthy Bold", size: 50) ?? UIFont.systemFont(ofSize: 40)
        ]
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(LetterManager().getLettersCount(profileName: profileInformation.name) > 0) {
           
            mailboxNewCountLabel.text = "  \(LetterManager().getLettersCount(profileName: profileInformation.name))  "
        }
        else {
            mailboxNewCountLabel.isHidden = true
        }
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
            print("name: \(profileInformation.name)")
            let controller = segue.destination as! SettingsViewController
            controller.profileInformation = profileInformation
        }
    }

    @IBAction func settingsAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    @IBAction func unwindToProfileViewController(segue: UIStoryboardSegue) {}
}

//
//  ForParentsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/5/21.
//

import UIKit

class ForParentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())

    var tableViewCells = [
        "Write Letter From Santa",
        "Write Letter From Elves",
        "Nice/Naught Feedback",
        "Back to profile"
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("name: \(profileInformation.name)")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        profileInformation.image = ProfileManager().getProfileImage(profileName: profileInformation.name)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(contentsOfFile: profileInformation.image), style: .plain, target: nil, action: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("PREPARED")
        if (segue.identifier == "writeFromSantaLetter") {
            let controller = segue.destination as! WriteLetterViewController
            
            controller.profileInformation = profileInformation
            controller.from = "Santa"
            
        }
        else if (segue.identifier == "writeFromElvesLetter") {
            let controller = segue.destination as! WriteLetterViewController
            
            controller.profileInformation = profileInformation
            controller.from = "Elves"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forParentCell", for: indexPath)
        
        cell.textLabel?.text = tableViewCells[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(tableViewCells[indexPath.row])
        
        switch tableViewCells[indexPath.row] {
        case "Write Letter From Santa":
            performSegue(withIdentifier: "writeFromSantaLetter", sender: nil)
//            print("Write Letter from Santa")
        case "Write Letter From Elves":
            performSegue(withIdentifier: "writeFromElvesLetter", sender: nil)
        case "Nice/Naughty Feedback":
            performSegue(withIdentifier: "nice/naughtyFeedback", sender: nil)
        case "Back to profile":
            self.performSegue(withIdentifier: "goBackToProfile", sender: self)
        default:
            return
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }


}

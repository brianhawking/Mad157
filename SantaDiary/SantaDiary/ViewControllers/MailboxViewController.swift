//
//  MailboxViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/17/21.
//

import UIKit

class MailboxViewController: UIViewController {


    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")
    
    @IBOutlet weak var tableView: UITableView!
    
    var results: [(image: String, date: String, message: String)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
    
        // tableview
        let nib  = UINib(nibName: "SantaLetterCell", bundle:  nil)
        tableView.register(nib, forCellReuseIdentifier: "SantaLetterCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // give dummy data
        let image = "OpenEnvelope"
        results.append((image: "ClosedEnvelope", date: "November 2, 2021", message: "LETTER FROM SANTA"))
        results.append((image: image, date: "July 2, 2021", message: "Dummy data: This is a message from Santa."))
        results.append((image: image, date: "October 24, 2021", message: "Dummy data: This is a message from Santa."))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromSantaSegue" {
            let controller = segue.destination as! ShowLetterFromSanta
            let row = sender as! Int //we know that sender is an NSIndexPath here.
            
            controller.profileInformation = profileInformation
            controller.dateOfLetter = results[row].date
            controller.to = "LetterFromSanta"
        }
    }

}

extension MailboxViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension MailboxViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
//    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        return false
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "fromSantaSegue", sender: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SantaLetterCell") as! SantaLetterCell
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.view.layer.cornerRadius = 20
        
        if (results[indexPath.row].image == "OpenEnvelope"){
            cell.view.layer.borderColor = UIColor.black.cgColor
            cell.view.layer.borderWidth = 2
        }
        else {
            cell.view.layer.borderColor = UIColor.yellow.cgColor
            cell.view.layer.borderWidth = 6
            cell.view.layer.shadowRadius = 5
            cell.view.layer.shadowColor = UIColor.yellow.cgColor
            cell.view.layer.shadowOpacity = 0.5
            cell.view.layer.shadowOffset = .zero
            cell.view.layer.shadowRadius = 3
        }
        

        cell.message.text = results[indexPath.row].message
        cell.date.text = results[indexPath.row].date
        cell.avatarImageView.image = UIImage(named: results[indexPath.row].image)
        
        
        return cell
    }
    
    
}


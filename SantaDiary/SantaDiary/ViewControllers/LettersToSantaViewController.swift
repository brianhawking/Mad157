//
//  LettersToSantaViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/17/21.
//

import UIKit

class LettersToSantaViewController: UIViewController {

    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")

    var results: [(image: String, date: String, message: String)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // filemanager to get data
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
        
        // tableview
        let nib  = UINib(nibName: "SantaLetterCell", bundle:  nil)
        tableView.register(nib, forCellReuseIdentifier: "SantaLetterCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // give dummy data
        results.append((image: "sleigh", date: "January 11, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "July 2, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "October 24, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "January 11, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "July 2, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "October 24, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "January 11, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "July 2, 2021", message: "This is a message to Santa."))
        results.append((image: "sleigh", date: "October 24, 2021", message: "This is a message to Santa."))
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSantaSegue" {
            let controller = segue.destination as! ShowLetterFromSanta
            let row = sender as! Int //we know that sender is an NSIndexPath here.
            
            controller.profileInformation = profileInformation
            controller.dateOfLetter = results[row].date
        }
        
        else if (segue.identifier == "toWriteLetter") {
            let controller = segue.destination as! WriteLetterViewController
            
            controller.profileInformation = profileInformation
        }
    }
    
    
    @IBAction func addLetter(_ sender: UIButton) {
        performSegue(withIdentifier: "toWriteLetter", sender: nil)
    }
    
    

}

extension LettersToSantaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension LettersToSantaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSantaSegue", sender: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SantaLetterCell") as! SantaLetterCell
        
        cell.backgroundColor = .clear
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.cornerRadius = 20
        cell.view.layer.borderWidth = 2

        cell.message.text = results[indexPath.row].message
        cell.date.text = results[indexPath.row].date
        
        
        return cell
    }
    
    
}

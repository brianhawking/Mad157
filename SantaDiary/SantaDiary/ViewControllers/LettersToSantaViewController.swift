//
//  LettersToSantaViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/17/21.
//

import UIKit

class LettersToSantaViewController: UIViewController {

    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")

    var letters: [(date: String, letter: String)] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // filemanager to get data
        getLetters(to: "LetterToSanta")
        
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
        
        // tableview
        let nib  = UINib(nibName: "SantaLetterCell", bundle:  nil)
        tableView.register(nib, forCellReuseIdentifier: "SantaLetterCell")
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    func getLetters(to: String) {
        
        letters = LetterManager().getLetters(profileName: profileInformation.name, to: to)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSantaSegue" {
            let controller = segue.destination as! ShowLetterFromSanta
            let row = sender as! Int //we know that sender is an NSIndexPath here.
            
            controller.profileInformation = profileInformation
            controller.dateOfLetter = letters[row].date
            controller.to = "LetterToSanta"
        }
        
        else if (segue.identifier == "toWriteLetter") {
            let controller = segue.destination as! WriteLetterViewController
            
            controller.profileInformation = profileInformation
            
            controller.completionHandler = { b in
                self.getLetters(to: "LetterToSanta")
                self.tableView.reloadData()
                print("new data listed")
            }
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
        return letters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSantaSegue", sender: indexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SantaLetterCell") as! SantaLetterCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.cornerRadius = 20
        cell.view.layer.borderWidth = 2

        cell.message.text = letters[indexPath.row].letter
        cell.date.text = letters[indexPath.row].date
        cell.avatarImageView.image = UIImage(named: SantaImages().letters.randomElement()!)
        
        
        return cell
    }
    
    
}

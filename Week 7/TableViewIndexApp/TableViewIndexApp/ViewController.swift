//
//  ViewController.swift
//  TableViewIndexApp
//
//  Created by Brian Veitch on 9/26/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var petTable: UITableView!
    
    let petArray = [["Bird", "parakeet", "parrot", "canary", "finch", "cockatiel"], ["Fish", "tropical fish", "goldfish", "sea horses", "eel"], ["Mammal", "cat", "dog", "hamster", "gerbil", "rabbit", "mouse"], ["Reptile", "turtle", "snake", "lizard"],["Bird", "parakeet", "parrot", "canary", "finch", "cockatiel"], ["Fish", "tropical fish", "goldfish", "sea horses", "eel"], ["Mammal", "cat", "dog", "hamster", "gerbil", "rabbit", "mouse"], ["Reptile", "turtle", "snake", "lizard"]]
    
    let indexArray = ["🦜B", "🐟F", "🐕M", "🦎R",x  "🦜B", "🐟F", "🐕M", "🦎R"]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        petTable.delegate = self
        petTable.dataSource = self
        
        petTable.sectionIndexColor = UIColor.white
        petTable.sectionIndexBackgroundColor = UIColor.black
        petTable.sectionIndexTrackingBackgroundColor = UIColor.darkGray
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petArray[section].count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = petArray[indexPath.section][indexPath.row + 1]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedItem = petArray[indexPath.section][indexPath.row + 1]
        let alert = UIAlertController(title: "Your Choice", message: "\(selectedItem)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
        //Just dismiss the action sheet
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return petArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return petArray[section][0]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexArray
    }

}


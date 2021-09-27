//
//  ViewController.swift
//  TableViewApp
//
//  Created by Brian Veitch on 9/26/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var petTable: UITableView!
    
    var petArray = ["cat", "dog", "parakeet", "parrot", "canary", "finch", "tropical fish", "goldfish", "sea horses", "hamster", "gerbil", "rabbit", "turtle", "snake", "lizard", "hermit crab"]
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        petTable.delegate = self
        petTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // get cell
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if (cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCell.CellStyle.default,
                reuseIdentifier: cellID)
        }
        cell?.textLabel?.text = petArray[indexPath.row]
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = petArray[indexPath.row]
        
        let alert = UIAlertController(title: "Your choice", message: "\(selectedItem)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action -> Void in
            // just dismiss the alert
        })
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }


}


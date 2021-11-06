//
//  ForParentsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/5/21.
//

import UIKit

class ForParentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableViewCells = ["Write letter", "Nice/Naught Feedback"]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forParentCell", for: indexPath)
        
        cell.textLabel?.text = tableViewCells[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
    }


}

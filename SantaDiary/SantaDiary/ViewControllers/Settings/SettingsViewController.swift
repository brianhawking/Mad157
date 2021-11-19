//
//  SettingsViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/4/21.
//

import UIKit

class SettingsViewController: UIViewController {

    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())

    @IBOutlet weak var tableView: UITableView!
    
    let tableViewCells = ["Change name", "Change avatar", "For parents"]
    
    let tableViewSegues = ["toPassword", "toPassword", "toPassword"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
        
        // set up table view delegate, datasourc

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        switch segue.identifier {
        case "toPassword":
            let controller = segue.destination as! PasswordViewController
            controller.profileInformation = profileInformation
        default:
            return
        }
        
        
        
    }

}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewCells.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
       
        performSegue(withIdentifier: "toPassword", sender: nil)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fakecell2", for: indexPath)
        
//        cell.cellTitle.text = tableViewCells[indexPath.row]
        cell.textLabel?.text = tableViewCells[indexPath.row]
        cell.textLabel?.tintColor = UIColor.black
        
        return cell
    }
    
    
}


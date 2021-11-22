//
//  CreateProfielViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 11/22/21.
//

import UIKit

class CreateProfielViewController: UIViewController {
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var profileDetailOptions: [String] = ["Name", "Birthday"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.layer.cornerRadius = 10
        
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.id)
        tableView.register(DatePickerTableViewCell.self, forCellReuseIdentifier: DatePickerTableViewCell.id)
        
    }
    

}

extension CreateProfielViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileDetailOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.id, for: indexPath) as? TextFieldTableViewCell else { return UITableViewCell() }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerTableViewCell.id, for: indexPath) as? DatePickerTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row ==
                1 {
         
            performSegue(withIdentifier: "toBirthdaySegue", sender: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBirthdaySegue" {
            let vc = segue.destination as! BirthdayViewController
            
        }
    }
    
}

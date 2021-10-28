//
//  ViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/8/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    
    var profileNames = [
        (name: "Connor", image: "image 1", age: "4"),
        (name: "Landon", image: "Rectangle 32", age: "1"),
        (name: "Piper", image: "dinosaur-1 1", age: "5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // filemanager to get profile info
        // name, image, age
        
        
        // connect to tableview cell
        let nib = UINib(nibName: "ProfileListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "ProfileListTableViewCell")
        
        tableview.delegate = self
        tableview.dataSource = self
    }


    // tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileNames.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProfileSegue", sender: indexPath);
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileListTableViewCell", for: indexPath) as! ProfileListTableViewCell
        
        cell.backgroundColor = .clear
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.cornerRadius = 20
        cell.view.layer.borderWidth = 2
        cell.name.text = profileNames[indexPath.row].name
        cell.age.text = profileNames[indexPath.row].age
        cell.avatarImageView.image = UIImage(named: profileNames[indexPath.row].image)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProfileSegue") {
            print("Segue")
            let controller = segue.destination as! ProfileViewController
            let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            print(row)
            controller.profileInformation = profileNames[row]
        }
    }
    
}


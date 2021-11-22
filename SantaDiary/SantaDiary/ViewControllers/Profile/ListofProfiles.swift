//
//  ViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/8/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableview: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    var profiles: [ProfileEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get profile names
        getProfiles()
        
        // connect to tableview cell
        let nib = UINib(nibName: "ProfileListTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "ProfileListTableViewCell")
        
        tableview.delegate = self
        tableview.dataSource = self
        
        // edit navigation bar
        navigationController?.navigationBar.tintColor = UIColor.white;
        
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
       // ProfileManager().changeName(from: "Bill", to: "Judy")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getProfiles()
        tableview.reloadData()
    }
    
    func getProfiles() {
        // grab all profiles from documents directory
        profiles = ProfileManager().getProfiles()
        
    }


    // tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 106
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toProfileSegue", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "ProfileListTableViewCell", for: indexPath) as! ProfileListTableViewCell
        
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.cornerRadius = 20
        cell.view.layer.borderWidth = 2
        cell.name.text = profiles[indexPath.row].name
        cell.age.text = profiles[indexPath.row].age()
        cell.avatarImageView.image = UIImage(named: profiles[indexPath.row].image)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProfileSegue") {
            print("Segue")
            let controller = segue.destination as! ProfileViewController
            let row = (sender as! NSIndexPath).row; //we know that sender is an NSIndexPath here.
            print(row)
//            controller.profileInformation = (name: profile.name, image: profile.image, age: profile.age)
            controller.profileInformation = profiles[row]

        }
    }
    
}


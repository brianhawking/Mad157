//
//  DiaryViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/17/21.
//

import UIKit

class DiaryViewController: UIViewController {

    
    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")
    
    @IBOutlet weak var monthYearLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    
    var monthYear = MonthYear()
    var results: [(image: String, date: String, message: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // put avatar in the top right navigation
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: profileInformation.image), style: .plain, target: nil, action: nil)
        
        monthYearLabel.text = monthYear.asString()
        
        // tableview
        let nib  = UINib(nibName: "SantaLetterCell", bundle:  nil)
        tableView.register(nib, forCellReuseIdentifier: "SantaLetterCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        // give dummy data
        results.append((image: "happy", date: "January 11, 2021", message: "I learned that the largest dinosaur was the Ultrasuarus"))
        results.append((image: "angry", date: "July 2, 2021", message: "I helped my mom do the dishes."))
        results.append((image: "happy", date: "October 24, 2021", message: "I really liked martial arts today."))
        
    }
    

    @IBAction func changeMonth(_ sender: UIButton) {
        
        if sender.tag == 1 {
            monthYear.back()
        }
        else {
            monthYear.forward()
        }
        
        monthYearLabel.text = monthYear.asString()
        
    }
    
}

extension DiaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension DiaryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SantaLetterCell") as! SantaLetterCell
        
        cell.backgroundColor = .clear
        cell.view.layer.borderColor = UIColor.black.cgColor
        cell.view.layer.cornerRadius = 20
        cell.view.layer.borderWidth = 2

        cell.message.text = results[indexPath.row].message
        cell.date.text = results[indexPath.row].date
        cell.avatarImageView.image = UIImage(named: results[indexPath.row].image)
        
        
        return cell
    }
    
    
}

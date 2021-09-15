//
//  ViewController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/12/21.
//

import UIKit

class Person {
    
    var name: String
    var partner: [Int] = []
    var children: [Int] = []
    var siblings: [Int] = []
    var parents: [Int] = []
    var id: Int
    var description: String = ""
    let sections: [String] = ["Partner", "Children", "Parents", "Siblings"]
    
    init(name: String, id: Int, description: String) {
        self.name = name
        self.id = id
        self.description = description
    }
    
    func getPersonData() -> [[Int]] {
        var array: [[Int]] = []
    
        array.append(self.partner)
        array.append(self.children)
        array.append(self.parents)
        array.append(self.siblings)
        
        return array
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // variables
    
    // array of everyone
    var persons: [Person] = []
    
    // current id
    var id: Int = 0
    
    // type of family member
    var addType: String = ""
    

    @IBOutlet weak var membersTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // hide back button in navigation controller
        navigationItem.hidesBackButton = true
        
        // set up tableview delegate and datasource
        membersTableView.delegate = self
        membersTableView.dataSource = self
        
        // initial data
        let person = Person(name: "Brian Veitch", id: 0, description: "Brian Veitch was born in 1983 to parents Kurt and Jeanne Veitch.")
        persons.append(person)
    }
    
    func getPersonData() -> [[Int]] {
        var array: [[Int]] = []
        array.append(persons[id].partner)
        array.append(persons[id].children)
        array.append(persons[id].parents)
        array.append(persons[id].siblings)
        
        return array
    }
    
    // get name of family member with id
    func getName(id: Int) -> String {
        return persons[id].name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return getPersonData().count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return persons[id].sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return getPersonData()[section].count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // get id of selected family member
        let chosenId = getPersonData()[indexPath.section][indexPath.row]
      
        nameLabel.text = getName(id: chosenId)
        id = chosenId
        membersTableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let array = getPersonData()
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath)
        cell.textLabel?.text = getName(id: array[indexPath.section][indexPath.row])
        
        return cell
    }
    
    @IBAction func openInfoAction(_ sender: Any) {
        performSegue(withIdentifier: "toInfoSegue", sender: nil)
    }
    
    @IBAction func addMemberAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            addType = "Parent"
        }
        else if sender.tag == 2 {
            addType = "Partner"
        }
        else if sender.tag == 3 {
            addType = "Child"
        }
        else {
            addType = "Sibling"
        }
        
        performSegue(withIdentifier: "addMemberSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toInfoSegue" {
            let vc = segue.destination as! ViewInfoController
            
            vc.name = persons[id].name
            vc.descriptionText = persons[id].description
        }
        
        if (segue.identifier == "addMemberSegue") {
            let vc = segue.destination as! AddMemberController
            
            vc.addType = addType
            vc.person = (name: persons[id].name, id: persons[id].id)
            vc.persons = persons
            vc.completionHandler = { name, id1, description in
                
                var newID = 0
                
                if (id1 == -1) {
                    newID = self.persons.count
                    self.persons.append(Person(name: name, id: newID, description: description))
                }
                else {
                    newID = id1
                    self.persons[newID].name = name
                    self.persons[newID].description = description
                }
                
                
                // linking
                
                if self.addType == "Partner" {
                    self.persons[self.id].partner.append(newID)
                    self.persons[newID].partner.append(self.id)
                }
                else if self.addType == "Sibling" {
                    self.persons[self.id].siblings.append(newID)
                    self.persons[newID].siblings.append(self.id)
                }
                else if self.addType == "Parent" {
                    self.persons[self.id].parents.append(newID)
                    self.persons[newID].children.append(self.id)
                }
                else if self.addType == "Child" {
                    self.persons[self.id].children.append(newID)
                    self.persons[newID].parents.append(self.id)
                }
                self.membersTableView.reloadData()
                
            }
            
        }
    
    }
    
}


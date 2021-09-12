//
//  ViewController.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/12/21.
//

import UIKit

class Person {
    var name: String
    var partner: String?
    var children: [String]?
    var siblings: [String]?
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var persons: [Person] = []
    var id: Int = 0
    var addType: String = ""

    @IBOutlet weak var membersTableView: UITableView!
    
    // variables
    var sections: [String] = ["Partner", "Parents", "Children"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let person = Person(name: "Brian Veitch", id: 0)
        persons.append(person)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons[id].children?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = membersTableView.dequeueReusableCell(withIdentifier: "memberCell")
        
        cell?.textLabel?.text = persons[id].children?[indexPath.row]
        
        return cell!
    }
    
    
    @IBAction func addMemberAction(_ sender: UIButton) {
        
        if sender.tag == 1 {
            addType = "Parent"
        }
        else if sender.tag == 2 {
            addType = "Partner"
        }
        else {
            addType = "Child"
        }
        
        performSegue(withIdentifier: "addMemberSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toMemberSegue") {
            let controller = segue.destination as! AddMemberController
            
            controller.addType = addType
            
            controller.callback = { message in
                        print("HI")
            }
            
        }
    }
    
    

}


//
//  ViewController.swift
//  BriansDBApp
//
//  Created by Brian Veitch on 10/2/21.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()

    @IBOutlet weak var displayDataHere: UILabel!
    
    @IBOutlet weak var enterGuitarDescription: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        displayDataHere.text?.removeAll()
        fetchData()
    }
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Item")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                let product = item.value(forKey: "about") as! String
                displayDataHere.text! += product
            }
        } catch  {
            print("ERROR")
        }
    }

    @IBAction func saveRecordButton(_ sender: UIButton) {
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Item", into: dataManager)
        newEntity.setValue(enterGuitarDescription.text!, forKey: "about")
        
        do {
            try self.dataManager.save()
            listArray.append(newEntity)
        }
        catch {
            print("Error saving data")
        }
        
        displayDataHere.text?.removeAll()
        enterGuitarDescription.text?.removeAll()
        fetchData()
    }
    
    
    @IBAction func deleteRecordButton(_ sender: UIButton) {
        let deleteItem = enterGuitarDescription.text!
        
        for item in listArray {
            if item.value(forKey: "about") as! String == deleteItem {
                dataManager.delete(item)
            }
            do {
                try self.dataManager.save()
            }
            catch {
                print("Error deleting data")
            }
            
            displayDataHere.text?.removeAll()
            enterGuitarDescription.text?.removeAll()
            fetchData()
        }
    }
    
    
    
}


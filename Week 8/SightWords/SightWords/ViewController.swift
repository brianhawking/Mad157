//
//  ViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 10/2/21.
//

import UIKit
import Foundation
import CoreData

class ViewController: UIViewController {
    
    // color scheme
    var colors = ColorScheme()
    
    // coreData set up
    var dataManager: NSManagedObjectContext!
    var listArray = [NSManagedObject]()
    
    // card and word outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    
    // words
    var listOfWords: [String] = []
    var wordIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set up data manager for core data
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataManager = appDelegate.persistentContainer.viewContext
        
        // set color scheme
        colors.load()
        
        // design
        setupCard()
        getWords()
        
    }
    
    
    
    // update listOfWords after adding a word
    override func viewDidAppear(_ animated: Bool) {
        
        updateWords()
        
        if listOfWords.count == 1 {
            wordLabel.text = listOfWords[0]
        }
        
        colors.load()
        setupCard()

    }
    
    func setupCard() {
        
        cardView.layer.cornerRadius =  30
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        cardView.layer.shadowOpacity = 0.8
        cardView.layer.shadowRadius = 10
       
        // set up color scheme
        cardView.backgroundColor = colors.styles[colors.index].cardBackground
        wordLabel.textColor = colors.styles[colors.index].textColor
        self.view.backgroundColor = colors.styles[colors.index].viewBackground
    }
    
    func getWords() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for word in listArray {
                let w = word.value(forKey: "word") as! String
                listOfWords.append(w)
            }
        } catch  {
            print("ERROR getting words")
        }
        
        // set to first word in list
        if listOfWords.count != 0 {
            wordLabel.text = listOfWords[0]
        }
        
    }
    
    // append new word to listOfWords
    func updateWords() {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for word in listArray {
                let w = word.value(forKey: "word") as! String
                if !listOfWords.contains(w) {
                    listOfWords.append(w)
                }
            }
        } catch  {
            print("ERROR getting words")
        }
        print(listOfWords)
    }

    // remove current word from DB and listOfWords
    @IBAction func deleteAction(_ sender: Any) {
        
        if listOfWords.count == 0 {
            return
        }
        
        let deleteItem = wordLabel.text!
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Words")
        do {
            let result = try dataManager.fetch(fetchRequest)
            listArray = result as! [NSManagedObject]
            for item in listArray {
                // delete if found
                if item.value(forKey: "word") as! String == deleteItem {
                    dataManager.delete(item)
                    listOfWords.remove(at: wordIndex)
                }
                do {
                    try self.dataManager.save()
                }
                catch {
                    print("Error deleting data")
                }
            }
        } catch  {
            print("ERROR")
        }
        
        // show previous word in list
        if wordIndex > 0 {
            wordIndex -= 1
        }
        else {
            wordIndex = 0
        }
        
        // if list is empty
        if listOfWords.count == 0 {
            wordLabel.text = ""
        }
        else {
            wordLabel.text = listOfWords[wordIndex]
        }
        
    }
    
    @IBAction func addAction(_ sender: Any) {
        performSegue(withIdentifier: "AddWordSegue", sender: nil)
    }
    
    
    @IBAction func nextAction(_ sender: UIButton) {
       
        wordIndex += 1
        
        if wordIndex >= listOfWords.count {
            wordIndex = 0
        }
        
        rotateCard(direction: "Right")
    }
    
    
    @IBAction func previousAction(_ sender: UIButton) {
        
        wordIndex -= 1
        
        if wordIndex < 0 {
            wordIndex = listOfWords.count-1
        }
        
        rotateCard(direction: "Left")
        
    }
        
    func rotateCard(direction: String) {
        
        // create animation for the rotation
        
        // clear the text
        wordLabel.text = ""
        
        if listOfWords.count == 0 {
            return
        }
        
        let rotate: UIView.AnimationOptions
        
        // set up flip direction
        switch direction {
        case "Left":
            rotate = .transitionFlipFromRight
        default:
            rotate = .transitionFlipFromLeft
        }
        
        UIView.transition(with: cardView, duration: 1, options: [rotate], animations: {
            self.wordLabel.text = self.listOfWords[self.wordIndex]
            }, completion: nil)
//
//        UIView.transition(with: wordLabel, duration: 1, options: [rotate], animations: {
//                self.wordLabel.text = self.listOfWords[self.wordIndex]
//            }, completion: nil)
       
    }
    
    
    @IBAction func shuffleAction(_ sender: Any) {
        
        listOfWords.shuffle()
        wordLabel.text = listOfWords[wordIndex]
        
    }

}


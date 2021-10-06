//
//  ViewController.swift
//  SightWords
//
//  Created by Brian Veitch on 9/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    var words:[String] = []
    var wordIndex: Int = 0
    
    var colors = ColorScheme()
    
    let imageSize:CGSize = CGSize(width: 20, height: 20)
    
    let userDefaults = UserDefaults.standard

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    
    @IBOutlet var buttons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        for button in buttons {
            button.layer.borderWidth = 2
            button.backgroundColor = UIColor.red
            button.layer.cornerRadius = 10
            button.setTitleColor(.white, for: .normal)
            
        }
        
        words = userDefaults.stringArray(forKey: "words") ?? []
        
        if words.isEmpty {
            wordLabel.text = ""
        }
        else {
            words.shuffle()
            wordLabel.text = words[wordIndex]
        }
    }

    @IBAction func removeWord(_ sender: Any) {
        words.remove(at: wordIndex)
        userDefaults.set(words, forKey: "words")
        if wordIndex == words.count {
            wordIndex -= 1
        }
        wordLabel.text = words[wordIndex]
    
    }
    @IBAction func playWordAction(_ sender: UIButton) {
 
    }
    
    
    @IBAction func moveAction(_ sender: UIButton) {
        if sender.tag == 1 {
            wordIndex -= 1
        }
        else {
            wordIndex += 1
        }
        
        if wordIndex < 0 {
            wordIndex = words.count-1
        }
        
        else if wordIndex >= words.count {
            wordIndex = 0
        }
        print("wordIndex: ", wordIndex)
        print("words.size", words.count)
       
        if words.count != 0 {
            wordLabel.text = words[wordIndex]
        }
        else {
            wordLabel.text = ""
        }
        
    }
    
    @IBAction func addWordAction(_ sender: Any) {
        
        performSegue(withIdentifier: "addWordSegue", sender: nil)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWordSegue" {
            let vc = segue.destination as! AddWordViewController
            
            vc.completionHandler = { word in
                
                // check if word exists
                if !self.words.contains(word) {
                    self.words.append(word)
                    self.userDefaults.set(self.words, forKey: "words")
                    self.wordLabel.text = self.words[self.wordIndex]
                }
                
            }
        }
    }
    
}


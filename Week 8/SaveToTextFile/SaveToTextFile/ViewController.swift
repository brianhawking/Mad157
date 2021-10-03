//
//  ViewController.swift
//  SaveToTextFile
//
//  Created by Brian Veitch on 10/2/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var typeTextHere: UITextView!
    
    @IBOutlet weak var displayTextHere: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        typeTextHere.text = "Type your new text right here..."
        displayTextHere.text = ""
    }


    @IBAction func writeMyText(_ sender: Any) {
        
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.last?.appendingPathComponent("file.txt")
        do {
            try typeTextHere.text.write(to: url!, atomically: true, encoding: String.Encoding.utf8)
            print(url!)
        } catch {
            print("Error writing file.")
        }
    }
    
    
    @IBAction func readMyText(_ sender: Any) {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        let url = urls.last?.appendingPathComponent("file.txt")
        do {
            let fileContents = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            displayTextHere.text = fileContents
        } catch {
            print("Error reading file.")
        }
    }
}


//
//  ViewController.swift
//  DatePickerApp
//
//  Created by Brian Veitch on 9/19/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myDatePicker: UIDatePicker!
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        myDatePicker.preferredDatePickerStyle = .wheels
    }

    func showAlert(dateTime: String) {
        
        let alert = UIAlertController(title: "Selected Date and Time", message: "\(dateTime)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action -> Void in
            // just dismiss
        })
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func getCurrentDateTIme(_ sender: UIButton) {
        
        let selectedDate: String = dateFormatter.string(from: myDatePicker.date)
        showAlert(dateTime: selectedDate)
        
        print(selectedDate)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        showAlert(dateTime: selectedDate)
        print(selectedDate)
    }
}


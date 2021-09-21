//
//  TimerController.swift
//  TabbedMiniAppBrianV
//
//  Created by Brian Veitch on 9/21/21.
//

import UIKit

class TimerController: UIViewController {
    
    var timerSet = false
    var timerStopped = false
    var timeLeftInSeconds: Int = 0
    var hoursLeft: Int = 0
    var minutesLeft: Int = 0
    var secondsLeft: Int = 0
    
    var timer: Timer!
    
    
    @IBOutlet weak var timerPicker: UIDatePicker!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var countdownView: UIView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    let dateFormatter: DateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dateFormatter.timeStyle = .short
        
        for button in buttons {
            button.backgroundColor = UIColor.gray
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = button.frame.height/2
            button.setTitleColor(UIColor.white, for: .normal)
        }
        
        timerPicker.setValue(UIColor.white, forKey: "textColor")
        
        countdownView.backgroundColor = UIColor.black
        countdownView.layer.cornerRadius = countdownView.frame.height/2
        countdownView.layer.borderColor = UIColor.white.cgColor
        countdownView.layer.borderWidth = 2
        countdownView.isHidden = true
    }
    

    @IBAction func startTimer(_ sender: UIButton) {

        if timerSet == true {
            if timerStopped == false {
                startButton.setTitle("Resume", for: .normal)
                timerStopped = true
                // stop timer
                timer.invalidate()
            }
            else {
                startButton.setTitle("Pause", for: .normal)
                timerStopped = false
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.updateCountdownTimer()
                    if self.timeLeftInSeconds == -1 {
                        self.countdownLabel.text = "00:00"
                    
                        timer.invalidate()
                        
                        // show alert
                        let alert = UIAlertController(title: "Warning", message: "Timer Finished!", preferredStyle: .alert)
                        
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: {action -> Void in
                            self.countdownView.isHidden = true
                            self.timerSet = false
                        })
                        
                        alert.addAction(okAction)
                        
                        self.present(alert, animated: true, completion: nil)
                        self.cancelTimer(Any?.self)
                    }
                }
            }
        }
        
        
        if timerSet == false {
            
            timerSet = true
            
            startButton.setTitle("Pause", for: .normal)
            
            // show countdown timer
            countdownView.isHidden = false
            
            print(timerPicker.countDownDuration)
            timeLeftInSeconds = Int(timerPicker.countDownDuration)
        
            updateCountdownTimer()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.updateCountdownTimer()
                if self.timeLeftInSeconds == -1 {
                    self.countdownLabel.text = "00:00"
                    timer.invalidate()
                    
                    // show alert
                    let alert = UIAlertController(title: "Warning", message: "Timer Finished!", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: {action -> Void in
                        self.countdownView.isHidden = true
                        self.timerSet = false
                    })
                    
                    alert.addAction(okAction)
                    
                    self.present(alert, animated: true, completion: nil)
                    self.cancelTimer(Any?.self)
                
                }
            }
            
        }
        
    }
    
    func updateCountdownTimer() {
        countdownLabel.text = getTimeComponents(timeLeftInSeconds: timeLeftInSeconds)
        timeLeftInSeconds -= 1
    }
    
    func getTimeComponents(timeLeftInSeconds: Int) -> String {
        
        var timeLeft: String = ""
        
        let hoursLeft = timeLeftInSeconds / 3600
        let minutesLeft = (timeLeftInSeconds % 3600) / 60
        let secondsLeft = (timeLeftInSeconds % 3600) % 60
        
        
        // get hours
        if hoursLeft == 0 {
            timeLeft = ""
        }
        else if hoursLeft > 0 && hoursLeft < 10 {
            timeLeft = "0\(hoursLeft):"
        }
        else {
            timeLeft = "\(hoursLeft):"
        }
        
        // get minutes
        if minutesLeft == 0 {
            timeLeft += "00:"
        }
        else if minutesLeft > 0 && minutesLeft < 10 {
            timeLeft += "0\(minutesLeft):"
        }
        else {
            timeLeft += "\(minutesLeft):"
        }
        
        // get seconds
        if secondsLeft == 0 {
            timeLeft += "00"
        }
        else if secondsLeft > 0 && secondsLeft < 10 {
            timeLeft += "0\(secondsLeft)"
        }
        else {
            timeLeft += "\(secondsLeft)"
        }
        
        return timeLeft
   
    }
    
    @IBAction func cancelTimer(_ sender: Any) {
        countdownView.isHidden = true
        timerSet = false
        timerStopped = false
        startButton.setTitle("Start", for: .normal)
        countdownLabel.text = "00:00:00"
        timeLeftInSeconds = 0
        timer.invalidate()
    }
}

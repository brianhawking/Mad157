//
//  StopwatchController.swift
//  TabbedMiniAppBrianV
//
//  Created by Brian Veitch on 9/21/21.
//

import UIKit

class StopwatchController: UIViewController {
    
    var timer = Timer()
    var timerOn = false
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    var timeInSecondsElapsed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for button in buttons {
            button.backgroundColor = UIColor.gray
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.cornerRadius = button.frame.height/2
            button.setTitleColor(UIColor.white, for: .normal)
        }
    }

    @IBAction func stopAction(_ sender: UIButton) {
    
        timer.invalidate()
        timerOn = false
        startButton.setTitle("Start", for: .normal)
        timeInSecondsElapsed = 0
        stopwatchLabel.text = "00:00:00"
    }
    
    func updateCountdownTimer() {
        stopwatchLabel.text = getTimeComponents(seconds: timeInSecondsElapsed)
        timeInSecondsElapsed += 1
    }
    
    
    @IBAction func startAction(_ sender: Any) {
        
        
        if timerOn == false {
            updateCountdownTimer()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                self.updateCountdownTimer()
            }
            startButton.setTitle("Stop", for: .normal)
            timerOn = true
        }
        else {
            timer.invalidate()
            startButton.setTitle("Start", for: .normal)
            timerOn = false
        }
        
        
        
    }
    
    func getTimeComponents(seconds: Int) -> String {
        
        var timeLeft: String = ""
        
        let hoursLeft = seconds / 3600
        let minutesLeft = (seconds % 3600) / 60
        let secondsLeft = (seconds % 3600) % 60
        
        
        // get hours
        if hoursLeft == 0 {
            timeLeft = "00:"
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
}

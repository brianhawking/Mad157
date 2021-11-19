//
//  ShowLetterFromSanta.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/25/21.
//

import UIKit

class ShowLetterFromSanta: UIViewController {
    
    // user info
    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())
    
    var dateOfLetter: String = ""
    var to: String = "LetterToSanta"
    
    
    // views
    @IBOutlet weak var reindeerImage: UIImageView!
    
    @IBOutlet weak var snowmanImage: UIImageView!
    
    @IBOutlet weak var letterTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get letter data
        getLetter()
        
        // change title of screen
        self.title = dateOfLetter
        
        // add padding to letterTextView
        letterTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
        letterTextView.backgroundColor = UIColor.white

      
        reindeerImage.transform = reindeerImage.transform.rotated(by: .pi * -1/3)
        snowmanImage.transform = snowmanImage.transform.rotated(by: .pi * 1/6)

        // tap gestures for stuff to happen
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(reindeerTapped(tapGestureRecognizer:)))
            reindeerImage.isUserInteractionEnabled = true
            reindeerImage.addGestureRecognizer(tapGestureRecognizer)
        
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(snowmanTapped(tapGestureRecognizer:)))
        
            snowmanImage.isUserInteractionEnabled = true
            snowmanImage.addGestureRecognizer(tapGestureRecognizer2)
        
    }
    
    func getLetter() {
        
        letterTextView.text = LetterManager().getLetter(profileName: profileInformation.name, date: dateOfLetter, to: to)

    }
    
    @objc func reindeerTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        
        UIImageView.animate(withDuration: 1, delay: 0.1, options: [.curveEaseIn], animations: {
            self.reindeerImage.transform = CGAffineTransform(translationX:375, y: 0)
            
        }, completion: { _ in
           
            UIImageView.animate(withDuration: 1, animations: {
                self.reindeerImage.transform = CGAffineTransform(translationX:0, y: 0)
                self.reindeerImage.transform = self.reindeerImage.transform.rotated(by: .pi * -1/3)
            })
            
        })
        
        
    }
    
    @objc func snowmanTapped(tapGestureRecognizer: UITapGestureRecognizer) {
    
        UIImageView.animate(withDuration: 0.75) { () -> Void in
          self.snowmanImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }

        UIImageView.animate(withDuration: 0.75, delay: 0, options: UIImageView.AnimationOptions.curveEaseIn, animations: { () -> Void in
          self.snowmanImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: {_ in
            UIImageView.animate(withDuration: 0.05) { () -> Void in
                self.snowmanImage.transform = self.snowmanImage.transform.rotated(by: .pi/6)            }
        })
    }
    

}

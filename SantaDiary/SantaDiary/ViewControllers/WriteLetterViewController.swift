//
//  WriteLetterViewController.swift
//  SantaDiary
//
//  Created by Brian Veitch on 10/26/21.
//

import UIKit

class WriteLetterViewController: UIViewController {
    
    // filemanager
    
    // user info
    var profileInformation: (name: String, image: String, age: String) = (name: "", image: "", age: "")
    
    // views
    
    @IBOutlet weak var letterTextView: UITextView!
    
    @IBOutlet weak var reindeerImage: UIImageView!
    @IBOutlet weak var reindeerImage2: UIImageView!
    
    @IBOutlet weak var snowmanImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // filemanager
        
        // view adjustments
        letterTextView.textContainerInset = UIEdgeInsets(top: 50, left: 20, bottom: 50, right: 20)
        
        reindeerImage.transform = reindeerImage.transform.rotated(by: .pi * -1/3)
        snowmanImage.transform = snowmanImage.transform.rotated(by: .pi * 1/6)
        
        // tap gestures
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(snowmanTapped(tapGestureRecognizer:)))
        
            snowmanImage.isUserInteractionEnabled = true
            snowmanImage.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(reindeerTapped(tapGestureRecognizer:)))
        
            reindeerImage.isUserInteractionEnabled = true
            reindeerImage.addGestureRecognizer(tapGestureRecognizer2)
        
        
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
    
    @IBAction func save(_ sender: UIButton) {
        
        // filemanager
        
        // go back
        
    }
}

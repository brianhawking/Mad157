//
//  NiceOrNaughty.swift
//  SantaDiary
//
//  Created by Brian Veitch on 9/9/21.
//

import UIKit

class NiceOrNaughty: UIViewController {
    
    // user info
    var profileInformation: ProfileEntry = ProfileEntry(name: "", image: "", birthDay: Date())

    // ui elements
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var NiceNaughtyImage: UIImageView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var feedbackView: UIView!
    
    @IBOutlet weak var kindnessProgressBar: UIProgressView!
    
    @IBOutlet weak var kindnessCumulative: UILabel!
    
    @IBOutlet weak var smileCumulative: UILabel!
    @IBOutlet weak var smileProgressBar: UIProgressView!
    
    @IBOutlet weak var goodDeedProgressBar: UIProgressView!
    
    @IBOutlet weak var goodDeedCumulative: UILabel!
    
    // progress bar variables
    var smileProgress: Float = 0.25
    var kindnessProgress: Float = 0.8
    var goodDeedProgress: Float = 0.5
    @IBOutlet weak var goodDeedStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide view
        feedbackView.isHidden = true
        
        prepCardRotation()
        

        profileName.text = "\(profileInformation.name), \(profileInformation.age())"
        
        // modify ui elements
        
        kindnessProgressBar.transform = kindnessProgressBar.transform.scaledBy(x: 1, y: 5)
        smileProgressBar.transform = smileProgressBar.transform.scaledBy(x: 1, y: 5)
        goodDeedProgressBar.transform = goodDeedProgressBar.transform.scaledBy(x: 1, y: 5)
//        goodDeedStackView.isHidden = true
        
        kindnessCumulative.layer.borderWidth = 1
        smileCumulative.layer.borderWidth = 1
        goodDeedCumulative.layer.borderWidth = 1
        
        animateProgressBars()
        
        feedbackView.layer.cornerRadius = 20
        feedbackView.layer.borderWidth = 2
        
        
        profileInformation.image = ProfileManager().getProfileImage(profileName: profileInformation.name)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(contentsOfFile: profileInformation.image), style: .plain, target: nil, action: nil)
    }
    
    func animateProgressBars() {
        kindnessProgressBar.progress = 0.0
        smileProgressBar.progress = 0.0
        goodDeedProgressBar.progress = 0.0
        
        UIView.animate(withDuration: 3.0) {
            self.kindnessProgressBar.setProgress(self.kindnessProgress, animated: true)
            self.smileProgressBar.setProgress(self.smileProgress, animated: true)
            self.goodDeedProgressBar.setProgress(self.goodDeedProgress, animated: true)
            
            self.kindnessCumulative.transform = CGAffineTransform(translationX:self.kindnessProgressBar.frame.width * CGFloat(self.kindnessProgress), y: 0)
            self.smileCumulative.transform = CGAffineTransform(translationX:self.smileProgressBar.frame.width * CGFloat(self.smileProgress), y: 0)
            self.goodDeedCumulative.transform = CGAffineTransform(translationX:self.goodDeedProgressBar.frame.width * CGFloat(self.goodDeedProgress), y: 0)
        }
        
    }
    
    
    func prepCardRotation() {
        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                        
            UIView.transition(with: self.feedbackView, duration: 1, options: [.transitionFlipFromLeft], animations: {
                self.feedbackView.isHidden = false
                }, completion: nil)
            
        })
    }
    
    

}

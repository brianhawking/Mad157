//
//  ViewController.swift
//  TicTacToeBrianV
//
//  Created by Brian Veitch on 8/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    // buttons for squares
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var playAgainButton: UIButton!
    
    // player indicator
    @IBOutlet weak var meateater: UIImageView!
    @IBOutlet weak var planteater: UIImageView!
    var indicator:[UIImageView] = []
    
    // "WINS" label for each player
    @IBOutlet weak var meateaterLabel: UILabel!
    @IBOutlet weak var planteaterLabel: UILabel!
    var winner:[UILabel] = []
    
    // draw label
    @IBOutlet weak var drawLabel: UILabel!
    
    // gameboard
    var gameboard:[String] = ["", "", "", "", "", "", "", "", "", ""]
    
    let winningPositions:[[Int]]  = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    
    // keeps track of which position the player won so I can highlight those squares
    var wonPosition: Int = 0
    
    // player images
    var players:[String] = ["meateater-100","planteater-100"]
    var player: Int = 0
    
    var movesRemaining = 9
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        indicator = [meateater, planteater]
        
        indicator[(player+1)%2].alpha = 0.2

        winner = [meateaterLabel, planteaterLabel]
        drawLabel.isHidden = true
        meateaterLabel.isHidden = true
        planteaterLabel.isHidden = true
        playAgainButton.isHidden = true
    }
    
    @IBAction func playAgainAction(_ sender: Any) {
        // reset board
        for button in buttons {
            button.setImage(UIImage(named: "empty"), for: .normal)
            button.alpha = 1
            button.isUserInteractionEnabled = true
        }
        
        // hide "WINS" labels
        for w in winner {
            w.isHidden = true
        }
        
        // show both user's image
        for i in indicator {
            i.isHidden = false
            i.alpha = 1
        }
        
        // reset gameboard
        gameboard = ["", "", "", "", "", "", "", "", ""]
        
        player = 0
        
        playAgainButton.isHidden = true
        drawLabel.isHidden = true
        movesRemaining = 9
    }
    
    @IBAction func selectSquareAction(_ sender: AnyObject) {
        
        // set image to current player's image
        sender.setImage(UIImage(named: players[player]), for: .normal)
        
        // update gameboard
        gameboard[sender.tag] = players[player]
        
        // remove ability to select a used square
        buttons[sender.tag].isUserInteractionEnabled = false
        
        
        // check for winner
        if checkForWinner() {
            
            // show "WINS" label
            winner[player].isHidden = false
            
            // remove the loser's image
            indicator[(player+1)%2].alpha = 0
            
            // dim all squares
            for button in buttons {
                button.alpha = 0.2
            }

            // highlight only the winning squares
            for position in winningPositions[wonPosition] {
                buttons[position].alpha = 1
            }
            
            playAgainButton.isHidden = false
        
            
        }
        else {
            
            // switch player
            indicator[player].alpha = 0.2
            indicator[(player+1)%2].alpha = 1
            player = (player+1)%2
            movesRemaining -= 1
            
            if movesRemaining == 0 {
                // draw
                playAgainButton.isHidden = false
                drawLabel.isHidden = false
                
                // dim all buttons
                for button in buttons {
                    button.alpha = 0.2
                }
                
            }
        }
    }
    
    func checkForWinner() -> Bool {
        // 8 winning positions
        
              
        for (index, winningPosition) in winningPositions.enumerated() {
            
            // keeps track of how many squares are used in a winning position
            var counter = 0

            for position in winningPosition {
                if gameboard[position] == players[player] {
                    counter += 1
                }
            }
            if counter == 3 {
                wonPosition = index
                return true
            }
        }
        
        return false
    }
    

}


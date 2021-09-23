//
//  ViewController.swift
//  TicTacToeBrianV
//
//  Created by Brian Veitch on 8/29/21.
//

import UIKit

class ViewController: UIViewController {
    
    var counter: Int = 0
    
    var onePlayer: Bool = false
    var piece: String = "meateater"
    var computerPlayer: Int = 0
    var locked: Bool = false
    var difficulty: String = "Easy"
    
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
        
       
        print(difficulty)
        if onePlayer == true {
            if onePlayer == true && piece == "planteater" {
                // computer playes first move
                locked = true
                computerPlayer = 0
                _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(computerPlays), userInfo: nil, repeats: false)
            } else {
                computerPlayer = 1
            }
        }
        
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
        
        if onePlayer == true && piece == "planteater" {
            // computer playes first move
            locked = true
            computerPlayer = 0
            _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(computerPlays), userInfo: nil, repeats: false)
        } else {
            computerPlayer = 1
            locked = false
        }
        
    }
    
    func showWinner() {
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
    
    func switchPlayer() {
        // switch player
        counter+=1
        indicator[player].alpha = 0.2
        indicator[(player+1)%2].alpha = 1
        player = (player+1)%2
        movesRemaining -= 1
        
        if onePlayer == true {
            if locked == true {
                locked = false
            }
            else {
                locked = true
                _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(computerPlays), userInfo: nil, repeats: false)

            }
        }
        
        
        
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
    
    func randomMove() -> Int {
        var possiblePositionsToPlay: [Int] = []
        
        for index in 0..<gameboard.count - 1 {
        
            if gameboard[index] == "" {
                // add possible slots
                    possiblePositionsToPlay.append(index)
                    }
                    else {
                        // draw
                    }
            }
        
        return possiblePositionsToPlay.randomElement()!
    
    }
    
    @objc func computerPlays() {
        // find index
        var position = 0
        
        // easy
        if difficulty == "Easy" {
            position = randomMove()
        }
        
        else if difficulty == "Medium" {
            let number = Int.random(in: 0..<10)
            if number < 7 {
                position = randomMove()
            }
            else {
                position = bestMove()
            }
        }
        else {
            position = bestMove()
        }
        
        buttons[position].setImage(UIImage(named: players[player]), for: .normal)
        
        UIView.transition(with: buttons[position], duration: 0.3, options: [.transitionFlipFromLeft], animations: {
            self.buttons[position].setImage(UIImage(named: self.players[self.player]), for: .normal)
            self.buttons[position].isUserInteractionEnabled = false
            
        }, completion: nil)

        gameboard[position] = players[player]

        buttons[position].isUserInteractionEnabled = false
        
        if checkForWinner() {
            showWinner()
        }
        else {
            _ = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { _ in
                self.switchPlayer()
            })
        }
    }
    
    @IBAction func selectSquareAction(_ sender: UIButton) {
        
        counter+=1
        if locked == true {
            return
        }
        
        // set image to current player's image
//        sender.setImage(UIImage(named: players[player]), for: .normal)
        
        UIView.transition(with: sender, duration: 0.3, options: [.transitionFlipFromLeft], animations: {
            sender.setImage(UIImage(named: self.players[self.player]), for: .normal)
            sender.isUserInteractionEnabled = false
            
        }, completion: nil)
        
        // update gameboard
        gameboard[sender.tag] = players[player]
        
        // remove ability to select a used square
        buttons[sender.tag].isUserInteractionEnabled = false
        
        
        // check for winner
        if checkForWinner() {
            showWinner()
        }
        else {
            
            _ = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false, block: { _ in
                self.switchPlayer()
            })
            
           
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
    
    func score(gameboard:[String]) -> Int {
        let player = (computerPlayer+1)%2
        if didWin(player: player) {
            return 100
        }
        else if didWin(player: computerPlayer) {
           return -100
        }
        else {
            return 0
        }
    }
    
    func didWin(player: Int) -> Bool {
        
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
    
    func bestMove() -> Int{
        
        var bestScore = -1000
        var bestMove = 0
        
        // computer plays
       
        for i in 0..<9 {
            if gameboard[i] == "" {
                gameboard[i] = players[computerPlayer]
                let score = minimax(board: gameboard, depth: 0, isMaximizing: false )
                gameboard[i] = ""
//                print(i, score)
                if (score > bestScore) {
                    bestMove = i
                    bestScore = score
                }
            }
            
        }
        print(bestMove)
        return bestMove
        
    }
    
    func checkForDraw() -> Bool {
        for i in 0..<9 {
            if gameboard[i] == "" {
                return false
            }
        }
        return true
    }
    
    func minimax(board: [String], depth: Int, isMaximizing: Bool) -> Int {
    
        if checkForWinnerV2(p: computerPlayer) {
            print("winner")
            return 10
        }
        else if checkForWinnerV2(p: (computerPlayer+1)%2) {
            print("loser")
            return -10
        }
        else if checkForDraw() {
            return 0
        }
        
        print(depth)
        
        if (isMaximizing) {
            var bestScore = -1000
            for i in 0..<9 {
                if gameboard[i] == "" {
                    gameboard[i] = players[computerPlayer]
                    let score = minimax(board: gameboard, depth: depth+1, isMaximizing: false)
                    gameboard[i] = ""
                    bestScore = max(score, bestScore)
                }
            }
            
            return bestScore
        }
        
        else {
            var bestScore = 1000
            for i in 0..<9 {
                if gameboard[i] == "" {
                    gameboard[i] = players[(computerPlayer+1)%2]
                    let score = minimax(board: gameboard, depth: depth+1, isMaximizing: true)
                    gameboard[i] = ""
                    bestScore = min(score, bestScore)
                }
            }
            
            return bestScore
        }
        
    }
    
    func checkForWinnerV2(p: Int) -> Bool {
        // 8 winning positions
        
              
        for (index, winningPosition) in winningPositions.enumerated() {
            
            // keeps track of how many squares are used in a winning position
            var counter = 0

            for position in winningPosition {
                if gameboard[position] == players[p] {
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


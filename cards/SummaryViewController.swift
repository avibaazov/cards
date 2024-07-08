//
//  SummaryViewController.swift
//  cards
//
//  Created by Student15 on 08/07/2024.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var playerScoreLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var player1Score: Int = 0
    var player2Score: Int = 0
    var player1Name: String = ""
    var player2Name: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayResults()
    }
    
    func displayResults() {
       
        playerScoreLabel.text = "\(player2Name): \(player2Score)"
        
        if player1Score > player2Score {
            playerScoreLabel.text = " Score:\(player1Score)"
            playerScoreLabel.sizeToFit()
            resultLabel.text = "\(player1Name) Wins!"
        } else if player2Score > player1Score {
            playerScoreLabel.text = "Score:\(player2Score)"
            playerScoreLabel.sizeToFit()
            resultLabel.text = "\(player2Name) Wins!"
            
        } else {
            playerScoreLabel.text = "Tie"
            resultLabel.text = "It's a tie!"
        }
    }
    
    @IBAction func returnToMainMenu(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}

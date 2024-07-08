//
//  GameController.swift
//  cards
//
//  Created by Student15 on 07/07/2024.
//

import UIKit

struct Card {
    let imageName: String
    let strength: Int
}

class GameController: UIViewController {
    
    @IBOutlet weak var cardImageView1: UIImageView!
    @IBOutlet weak var cardImageView2: UIImageView!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    var userName: String = ""
    var userSide: String = ""
    var player1Name: String = ""
    var player2Name: String = "PC"
    var player1Score = 0
    var player2Score = 0
    var gameCount = 0
    let totalGames = 10
    var timer: Timer?
    var deck: [Card] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("GameController loaded")
        print("userName: \(userName)")
        print("userSide: \(userSide)")
        initializeDeck()
        setupPlayers()
        startGame()
    }
    func setupPlayers() {
            if userSide == "left" {
                player1Name = userName
                player2Name = "PC"
            } else {
                player1Name = "PC"
                player2Name = userName
            }
            updateScoreLabels()
        }
    func initializeDeck() {
        let suits = ["clubs", "diamonds", "hearts", "spades"]
        let ranks = ["2", "3", "4", "5", "6"]
        var cardStrength = 2
        
        for rank in ranks {
            for suit in suits {
                let cardName = "\(rank)_of_\(suit)"
                let card = Card(imageName: cardName, strength: cardStrength)
                deck.append(card)
            }
            cardStrength += 1
        }
    }
    
    func startGame() {
        gameCount = 0
        player1Score = 0
        player2Score = 0
        updateScoreLabels()
        startGameLoop()
    }
    
    func startGameLoop() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(playRound), userInfo: nil, repeats: true)
    }
    
    @objc func playRound() {
        guard gameCount < totalGames else {
            endGame()
            return
        }
        
        // Display cards
        let card1 = getRandomCard()
        let card2 = getRandomCard()
        cardImageView1.image = UIImage(named: card1.imageName)
        cardImageView2.image = UIImage(named: card2.imageName)
        
        // Update scores
        if card1.strength > card2.strength {
            player1Score += 10
        } else if card2.strength > card1.strength {
            player2Score += 10
        }
        
        updateScoreLabels()
        
        // Hide cards after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.cardImageView1.image = nil
            self.cardImageView2.image = nil
        }
        
        gameCount += 1
    }
    
    func getRandomCard() -> Card {
        let index = Int(arc4random_uniform(UInt32(deck.count)))
        return deck[index]
    }
    
    func updateScoreLabels() {
            player1ScoreLabel.text = "\(player1Name): \(player1Score)"
            player2ScoreLabel.text = "\(player2Name): \(player2Score)"
            player1ScoreLabel.sizeToFit()
            player2ScoreLabel.sizeToFit()
        }
    
    func endGame() {
            timer?.invalidate()
            if let summaryVC = storyboard?.instantiateViewController(withIdentifier: "SummaryViewController") as? SummaryViewController {
                summaryVC.player1Score = player1Score
                summaryVC.player2Score = player2Score
                summaryVC.player1Name = player1Name
                summaryVC.player2Name = player2Name
                navigationController?.pushViewController(summaryVC, animated: true)
            }
        }
    
 
    }


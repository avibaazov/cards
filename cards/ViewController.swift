//
//  ViewController.swift
//  cards
//
//  Created by Student15 on 07/07/2024.
//
import UIKit

typealias CLLocationDegrees = Double

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet var addName: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sideLabel: UILabel! // New label for indicating the side
    var userName: String = ""
    var userSide: String = ""
    let dummyLatitude: CLLocationDegrees = 34.0 // Example latitude for testing
    let midpointLatitude: CLLocationDegrees = 34.817549168324334
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("View did load")
        
        // Check if a name is already saved
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            // User has already entered their name
            userName=savedName
            print("Saved name found: \(savedName)")
            nameLabel.text = "Hi \(savedName)"
            nameField.isHidden = true
            addName.isHidden = true
            nameLabel.isHidden = false
            startButton.isHidden = true
            sideLabel.isHidden = true
            determineUserSide(dummyLatitude: dummyLatitude)
        } else {
            // User needs to enter their name
            print("No saved name found")
            nameField.isHidden = false
            addName.isHidden = false
            nameLabel.isHidden = true
            startButton.isHidden = true
            sideLabel.isHidden = true
        }
    }
    
    func determineUserSide(dummyLatitude: CLLocationDegrees) {
        if dummyLatitude > midpointLatitude {
            print("You are on the East Side")
            sideLabel.text = "You will play on the East Side"
            userSide = "right"
        } else {
            print("You are on the West Side")
            sideLabel.text = "You will play on the West Side"
            userSide = "left"
            
        }
        sideLabel.isHidden = false
        startButton.setTitle("Start", for: .normal)
        startButton.isHidden = false
    }
    
    @IBAction func addNameTapped(_ sender: UIButton) {
        if let name = nameField.text, !name.isEmpty {
            // Save the name
            UserDefaults.standard.set(name, forKey: "userName")
            print("Name saved: \(name)")
            userName=name
            // Update the UI
            nameLabel.text = "Hi \(name)"
            nameField.isHidden = true
            addName.isHidden = true
            nameLabel.isHidden = false
            determineUserSide(dummyLatitude: dummyLatitude)
        } else {
            print("Name field is empty")
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // Print debug information
        print("Start button tapped")
        
        // Navigate to the next screen
        if let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameController") as? GameController {
            gameVC.userName = self.userName
            gameVC.userSide = self.userSide
            navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
}

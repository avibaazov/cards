//
//  ViewController.swift
//  cards
//
//  Created by Student15 on 07/07/2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var addName: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        // Check if a name is already saved
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            // User has already entered their name
            print("Saved name found: \(savedName)")
            nameLabel.text = "Hi \(savedName)"
            nameField.isHidden = true
            addName.isHidden = true
            nameLabel.isHidden = false
        } else {
            // User needs to enter their name
            nameField.isHidden = false
            addName.isHidden = false
            nameLabel.isHidden = true
        }
    }

    @IBAction func addNameTapped(_ sender: UIButton) {
        if let name = nameField.text, !name.isEmpty {
            // Save the name
            UserDefaults.standard.set(name, forKey: "userName")
            
            // Update the UI
            nameLabel.text = "Hi \(name)"
            nameField.isHidden = true
            addName.isHidden = true
            nameLabel.isHidden = false
        }
    }
    
   // @IBAction func startButtonTapped(_ sender: UIButton) {
        // Navigate to the next screen
     //   performSegue(withIdentifier: "showGameScreen", sender: nil)
   // }
}

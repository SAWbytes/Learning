//
//  ViewController.swift
//  Bullseye
//
//  Created by Shane A. Wilson on 11/10/18.
//  Copyright © 2018 SAW inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue = 0
    
    var targetValue = 0
    
    var score = 0
    
    var round = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var roundLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startNewGame()
        
        let thumbImageNormal = #imageLiteral(resourceName: "bullseye-transparent-png-5")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlited = #imageLiteral(resourceName: "Colored_Bullseye 6.48.15 PM")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "green-button-png-3")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "images")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
    }

    @IBAction func showAlert() {
        
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        if difference == 0 {
            points += 100
        }else if difference == 1 {
            points += 50
            
        }
        
        score += points
        
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference < 10 {
            title = "Not bad"
        } else if difference < 20 {
            title = "Baka"
        } else {
            title = "Wow, you are terrible...."
        }
        
        let message = "You scored \(points) points!"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    @IBAction func slidermoved(_ slider: UISlider)  {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
    }
    
    func startNewRound() {
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLable.text = String(score)
        roundLable.text = String(round)
        
    }
    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
        
    }
        
}


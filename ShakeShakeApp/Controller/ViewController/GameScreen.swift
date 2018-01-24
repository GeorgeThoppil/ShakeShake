//
//  GameScreen.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-17.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import CoreMotion

class GameScreen: UIViewController {

    @IBOutlet weak var gameScore: UITextField!
    @IBOutlet weak var inGameCountDown: UIImageView!
    @IBOutlet weak var gameTimer: UITextField!
    
    var score : Int! = 0
    var timeLeft : Int! = 5
    let motionManager = CMMotionManager()
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if animated {
            //start the animation with various pictures
            inGameCountDown.animationImages = [UIImage(named: "GameTime-3")!, UIImage(named: "GameTime-2")!, UIImage(named: "GameTime-1")!,UIImage(named: "ShakeShake")! ]
            inGameCountDown.animationRepeatCount = 1
            inGameCountDown.animationDuration = 4
            inGameCountDown.startAnimating()
           
            //wait for the GameCountDown to finish and start the game timer and acceleration detection on the y-axis
            Timer.scheduledTimer(withTimeInterval: inGameCountDown.animationDuration, repeats: false, block: { (timer) in
                self.gameTimer.text = String(self.timeLeft)
                self.inGameCountDown.image = UIImage(named: "ShakeShake")
                self.startGameTimer()
                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
                    if(Int((motion?.userAcceleration.y.rounded())!) != 0) {
                         self.score = self.score + 1
                         self.gameScore.text = String(self.score)
                    }
                })
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            
            if let destinationVC = segue.destination as? Results {                 
                if score > defaults.integer(forKey: "Highscore") {
                    defaults.set(String(score), forKey: "Highscore")
                    destinationVC.isNewHighScore = true
                }
                destinationVC.score = score
            }
        }
    }
    
    
    //  =========================================================
    //  Method: startGameTimer
    //  Desc:   Start the game timer and decrement every second till it reaches 0.
    //          Check if it is highscore and perform segue to results screen
    //  Args:   None
    //  Return: None
    //  =========================================================
    func startGameTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timeLeft = self.timeLeft - 1
            if self.timeLeft == 0 {
                timer.invalidate()
                self.motionManager.stopDeviceMotionUpdates()
                self.performSegue(withIdentifier: "goToResults", sender: self)
            }
            else {
                self.gameTimer.text = String(self.timeLeft)
            }
        })
    }
}

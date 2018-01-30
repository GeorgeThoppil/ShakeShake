//
//  GameScreen.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-17.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import CoreMotion
import AudioToolbox
import Firebase

class GameScreen: UIViewController {

    @IBOutlet weak var gameScore: UITextField!
    @IBOutlet weak var inGameCountDown: UIImageView!
    @IBOutlet weak var gameTimer: UITextField!
    @IBOutlet weak var gameScoreTitle: UITextField!
    

    var timeLeft : Int! = 5
    let darkModePointsNeeded : Int! = 100000
    let motionManager = CMMotionManager()
    let defaults = UserDefaults.standard
    
    var currentPlayer : Player!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPlayer = Player(highScore: defaults.integer(forKey: "highScore") , totalScore: defaults.integer(forKey: "totalScore") , username: defaults.string(forKey: "userName")!, fireBaseId : defaults.string(forKey: "fireBaseId")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if animated {
            gameScore.text = "0"
            gameScoreTitle.text = "Score"
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
                        self.currentPlayer.inGameScore = self.currentPlayer.inGameScore + 1
                        self.gameScore.text = String(self.currentPlayer.inGameScore)
                    }
                })
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            
            if let destinationVC = segue.destination as? Results {
                
                //calculate new total score and save locally
                let newTotalScore = currentPlayer.inGameScore + currentPlayer.totalScore
                currentPlayer.totalScore = newTotalScore
                defaults.set(newTotalScore , forKey: "totalScore")
                
                //new total score exceeds the dark mode points needed, set flag to be true
                if newTotalScore > darkModePointsNeeded {
                    currentPlayer.unlockedDarkMode = true
                    defaults.set(true, forKey: "UnlockDarkMode")
                }
                
                if currentPlayer.inGameScore > currentPlayer.highScore {
                    defaults.set(currentPlayer.inGameScore, forKey: "highScore")
                    currentPlayer.highScore = currentPlayer.inGameScore
                    destinationVC.isNewHighScore = true
                }
             
                publishToFireBase(values: ["userName": currentPlayer.username, "highScore": currentPlayer.highScore, "totalScore": currentPlayer.totalScore, "unlockedDarkMode" : currentPlayer.unlockedDarkMode])
                destinationVC.score = currentPlayer.inGameScore
            }
        }
    }
    
    func publishToFireBase(values : Dictionary<String, Any>) -> Void {
        let ref = Database.database().reference().child("scores")
        ref.child(currentPlayer.fireBaseId ).setValue(values, withCompletionBlock: { (err, db) in
            self.getTopTenHighScores()
        })
    }
    
    func getTopTenHighScores() -> Void {
        Database.database().reference().child("scores").queryOrdered(byChild: "highScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
            print(snapShot)
        }, withCancel: { (err) in
            
        })
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
                //start vibration
                if(self.timeLeft  <= 3)
                {
                     AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                self.gameTimer.text = String(self.timeLeft)
            }
        })
    }
}

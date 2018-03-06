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
    @IBOutlet weak var gameTimer: UITextField!
    @IBOutlet weak var gameScoreTitle: UITextField!
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var shakeSkin: UIImageView!  
    
    var timeLeft : Int! = 15
    var selectedSkinName:String!
    let darkModePointsNeeded : Int! = 100000
    let motionManager = CMMotionManager()
    let defaults = UserDefaults.standard
    
  
    var currentPlayer : Player!
 
    override func viewDidLoad() {
        super.viewDidLoad()
         gameScoreTitle.text = "START SHAKING IN"   
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if animated {
            //gameScore.text = "0"
            
            //start the animation with various pictures
//            inGameCountDown.animationImages = [UIImage(named: "GameTime-3")!, UIImage(named: "GameTime-2")!, UIImage(named: "GameTime-1")!,UIImage(named: selectedSkinName)! ]
//            inGameCountDown.animationRepeatCount = 1
//            inGameCountDown.animationDuration = 4
//            inGameCountDown.startAnimating()
            
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                self.counter.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            }, completion: { (finished) in
                
                UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                    self.counter.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { (finished) in
                    self.counter.text = String(Int(self.counter.text!)! - 1)
                    
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                        self.counter.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
                    }, completion: { (finished) in
                        
                        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                            self.counter.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                        }, completion: { (finished) in
                            self.counter.text = String(Int(self.counter.text!)! - 1)
                            UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                                self.counter.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
                            }, completion: { (finished) in
                                
                                UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
                                    self.counter.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                                }, completion: { (finished) in
                                    self.counter.isHidden = true
                                    self.shakeSkin.isHidden = false
                                    self.gameScore.text = "0"                                   
                                    self.gameScoreTitle.text = "Score"
                                    self.gameTimer.text = "00:" + String(self.timeLeft)
                                    self.shakeSkin.image = UIImage(named: self.selectedSkinName)
                                    
                                    self.startGameTimer()
                                    self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
                                        if(Int((motion?.userAcceleration.y.rounded())!) != 0) {
                                            self.currentPlayer.inGameScore = self.currentPlayer.inGameScore + 1
                                            self.gameScore.text = String(self.currentPlayer.inGameScore)
                                        }
                                    })
                                    
                                    
                                })
                            })
                            
                        })
                    })
                    
                })
            })
           
            //wait for the GameCountDown to finish and start the game timer and acceleration detection on the y-axis
//            Timer.scheduledTimer(withTimeInterval: 6.0, repeats: false, block: { (timer) in
//                self.gameTimer.text = String(self.timeLeft)
//                self.inGameCountDown.image = UIImage(named: self.selectedSkinName)
//                self.startGameTimer()
//                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
//                    if(Int((motion?.userAcceleration.y.rounded())!) != 0) {
//                        self.currentPlayer.inGameScore = self.currentPlayer.inGameScore + 1
//                        self.gameScore.text = String(self.currentPlayer.inGameScore)
//                    }
//                })
//            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            
            if let destinationVC = segue.destination as? Results {               
                destinationVC.currentPlayer = currentPlayer
            }
        }
    }
    
    //  =========================================================
    //  Method: saveResults
    //  Desc:   Save game results locally and to the player object
    //  Args:   None
    //  Return: None
    //  =========================================================
    func saveResults() -> Void {
        
        //calculate new total score and save locally
        let newTotalScore = currentPlayer.inGameScore + currentPlayer.totalScore
        currentPlayer.totalScore = newTotalScore
        defaults.set(newTotalScore , forKey: "totalScore")
        
        //new total score exceeds the dark mode points needed, set flag to be true
        if newTotalScore > darkModePointsNeeded {
            currentPlayer.unlockedDarkMode = true
            defaults.set(true, forKey: "UnlockDarkMode")
        }
        
        //if in game score is higher than current highscore, register new game score as highscore
        if currentPlayer.inGameScore > currentPlayer.highScore {
            defaults.set(currentPlayer.inGameScore, forKey: "highScore")
            currentPlayer.highScore = currentPlayer.inGameScore
        }
    }
    
    //  =========================================================
    //  Method: publishToFireBase
    //  Desc:   Publish the game results back to firebase
    //  Args:   Dictionary<String, Any>
    //  Return: None
    //  =========================================================
    func publishToFireBase(values : Dictionary<String, Any>) -> Void {
        let ref = Database.database().reference().child("scores")
        ref.child(currentPlayer.fireBaseId ).setValue(values)
    }
    
    
    //  =========================================================
    //  Method: startGameTimer
    //  Desc:   Start the game timer and decrement every second till it reaches 0.
    //          Once it reaches 0, save the results locally, publish results to firebase
    //          and preform segue to next screen
    //  Args:   None
    //  Return: None
    //  =========================================================
    func startGameTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.timeLeft = self.timeLeft - 1
            if self.timeLeft == 0 {
                timer.invalidate()
                self.motionManager.stopDeviceMotionUpdates()
                self.saveResults()
                self.publishToFireBase(values: ["userName": self.currentPlayer.username, "highScore": self.currentPlayer.highScore, "totalScore": self.currentPlayer.totalScore, "unlockedDarkMode" : self.currentPlayer.unlockedDarkMode])
                self.performSegue(withIdentifier: "goToResults", sender: self)
            }
            else {
                //start vibration
                if(self.timeLeft  <= 3)
                {
                     AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                }
                if self.timeLeft < 10 {
                     self.gameTimer.text = "00:0" + String(self.timeLeft)
                }
                else{
                     self.gameTimer.text = "00:" + String(self.timeLeft)
                }
               
            }
        })
    }
}

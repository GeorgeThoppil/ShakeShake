//
//  GameScreen.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-17.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class GameScreen: UIViewController {

    @IBOutlet weak var gameScore: UITextField!
    @IBOutlet weak var inGameCountDown: UIImageView!
    @IBOutlet weak var gameTimer: UITextField!
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()          
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        //if the subtype is of motionshake and the timer has been started, increment the game score
        if event?.subtype == UIEventSubtype.motionShake && timer.isValid {
            gameScore.text = String(Int(gameScore.text!)! + 1)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if animated {
            //start the animation with various pictures
            inGameCountDown.animationImages = [UIImage(named: "GameTime-3")!, UIImage(named: "GameTime-2")!, UIImage(named: "GameTime-1")!,UIImage(named: "ShakeShake")! ]
            inGameCountDown.animationRepeatCount = 1
            inGameCountDown.animationDuration = 4
            inGameCountDown.startAnimating()
           
            //wait for the GameCountDown to finish and start the game timer
            Timer.scheduledTimer(withTimeInterval: inGameCountDown.animationDuration, repeats: false, block: { (timer) in
                self.gameTimer.text = "15"
                self.inGameCountDown.image = UIImage(named: "ShakeShake")
                self.startGameTimer()
            })
        
        }
    }
    
    
    //  =========================================================
    //  Method: startGameTimer
    //  Desc:   Start the game timer and decrement every second till it reaches 0. Perform segue to results screen thereafter
    //  Args:   None
    //  Return: None
    //  =========================================================
    func startGameTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if Int(self.gameTimer.text!) == 0 {
                timer.invalidate()
                print("asdasd")
            }
            else {
                 self.gameTimer.text = String((Int(self.gameTimer.text!)! - 1))
            }
        })
    }
}

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
    var timer = Timer()
    let motionManager = CMMotionManager()
    
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
                self.gameTimer.text = "15"
                self.inGameCountDown.image = UIImage(named: "ShakeShake")
                self.startGameTimer()
                self.motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: { (motion, error) in
                    if(Int((motion?.userAcceleration.y.rounded())!) != 0) {
                         self.gameScore.text = String(Int(self.gameScore.text!)! + 1)
                    }
                })
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
                 self.motionManager.stopDeviceMotionUpdates()
                print("asdasd")
            }
            else {
                 self.gameTimer.text = String((Int(self.gameTimer.text!)! - 1))
            }
        })
    }
}

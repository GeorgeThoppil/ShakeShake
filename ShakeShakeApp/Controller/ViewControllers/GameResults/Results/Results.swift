//
//  Results.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-23.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase
import UICircularProgressRing

class Results: UIViewController,  UICircularProgressRingDelegate  {
        
    @IBOutlet weak var gameProgress: UICircularProgressRingView!
    
    @IBAction func goToMenu(_ sender: Any) {
     performSegue(withIdentifier: "goToMenu", sender: self)
    }
    var currentPlayer : Player!
    let scoresRef = Database.database().reference(withPath: "scores")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresRef.keepSynced(true)
        gameProgress.delegate = self
        
        print(self.currentPlayer.toNextLevel())
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (Timer) in
            self.gameProgress.font = UIFont.systemFont(ofSize: 50)
            self.gameProgress.animationStyle = kCAMediaTimingFunctionLinear
            self.gameProgress.setProgress(value: CGFloat(self.currentPlayer.toNextLevel()), animationDuration: 5, completion: nil)
        }
      
    }
    
    func finishedUpdatingProgress(forRing ring: UICircularProgressRingView) {
        
        if ring === gameProgress {
            print("Done")
        }
    }
    
}

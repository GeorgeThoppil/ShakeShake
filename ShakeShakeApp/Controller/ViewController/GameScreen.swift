//
//  GameScreen.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-17.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class GameScreen: UIViewController {

    @IBOutlet weak var inGameCountDown: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()          
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if animated {
            
            inGameCountDown.animationImages = [UIImage(named: "GameTime-3")!, UIImage(named: "GameTime-2")!, UIImage(named: "GameTime-1")!,UIImage(named: "ShakeShake")! ]
            inGameCountDown.animationRepeatCount = 1
            inGameCountDown.animationDuration = 4
            inGameCountDown.startAnimating()
            inGameCountDown.image = UIImage(named: "ShakeShake")
            
        }
    }
    
}

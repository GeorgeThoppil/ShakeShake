//
//  MainMenu.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-15.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class MainMenu: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var highScore: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = defaults.string(forKey: "Username")
        highScore.text = defaults.string(forKey: "Highscore")
        
    }

    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "goToGameScreen", sender: self)
    }
    
    
}

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
    var userNameFromSegue : String = ""
    var highScoreFromSegue : String = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = userNameFromSegue
        highScore.text = highScoreFromSegue
        // Do any additional setup after loading the view.
    }

    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "goToGameScreen", sender: self)
    }
    
    
}

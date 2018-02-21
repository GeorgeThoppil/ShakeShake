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
    @IBOutlet weak var totalScore: UITextField!
    
    let defaults = UserDefaults.standard
    var currentPlayer : Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = Player(highScore: defaults.integer(forKey: "highScore") , totalScore: defaults.integer(forKey: "totalScore") , username: defaults.string(forKey: "userName")!, fireBaseId : defaults.string(forKey: "fireBaseId")!)
        
        userName.text = currentPlayer.username
        highScore.text = String(currentPlayer.highScore)
        totalScore.text = String(currentPlayer.totalScore)
        
    }
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "selectInGameShakePic", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {       
       self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectInGameShakePic" {
            
            if let destinationVC = segue.destination as? SelectInGameShakePic {
                destinationVC.currentPlayer = currentPlayer
            }
        }
    }
}

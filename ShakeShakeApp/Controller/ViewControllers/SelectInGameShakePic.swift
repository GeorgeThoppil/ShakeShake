//
//  Settings.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-28.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class SelectInGameShakePic: UIViewController {

    
    var currentPlayer : Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func goToGameScreen(_ sender: Any) {
        performSegue(withIdentifier: "goToGameScreen", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.topItem?.title = "Select Shaker"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameScreen" {
            
            if let destinationVC = segue.destination as? GameScreen {
                destinationVC.currentPlayer = currentPlayer
            }
        }
    }
    
    
    

}

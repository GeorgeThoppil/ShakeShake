//
//  Results.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-23.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class Results: UIViewController {
        
    @IBAction func goToMenu(_ sender: Any) {
     performSegue(withIdentifier: "goToMenu", sender: self)
    }
    var currentPlayer : Player!
    let scoresRef = Database.database().reference(withPath: "scores")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresRef.keepSynced(true)
    }
    
}

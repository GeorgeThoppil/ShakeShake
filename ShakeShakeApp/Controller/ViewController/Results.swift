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
    
    var currentPlayerResults : Player!
    let scoresRef = Database.database().reference(withPath: "scores")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoresRef.keepSynced(true)
        getTopTenHighScores()
    }
    
    
    
        func getTopTenHighScores() -> Void {
            scoresRef.queryOrdered(byChild: "highScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
                print(snapShot)
            }, withCancel: { (err) in
    
            })
        }
    
    
    
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
}

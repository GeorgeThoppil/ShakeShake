//
//  TopTenScores.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-03.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class TopTenHighScores: UIViewController {

    
    let scoresRef = Database.database().reference(withPath: "scores")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func getTopTenHighScores() -> Void {
        scoresRef.queryOrdered(byChild: "highScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
            print(snapShot)
        }, withCancel: { (err) in
            
        })
    }
    
}

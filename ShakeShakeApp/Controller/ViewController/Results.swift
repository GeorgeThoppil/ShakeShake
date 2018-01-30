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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    //    func getTopTenHighScores() -> Void {
    //        Database.database().reference().child("scores").queryOrdered(byChild: "highScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
    //            print(snapShot)
    //        }, withCancel: { (err) in
    //
    //        })
    //    }
    //
    
    
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
}

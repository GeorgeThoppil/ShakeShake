//
//  Results.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-23.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class Results: UIViewController {
    

    var score:Int!
    var isNewHighScore:Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goHome(_ sender: Any) {
        performSegue(withIdentifier: "goToHome", sender: self)
    }
}

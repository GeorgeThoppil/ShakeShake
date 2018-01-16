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
    var userNameFromSegue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = userNameFromSegue
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

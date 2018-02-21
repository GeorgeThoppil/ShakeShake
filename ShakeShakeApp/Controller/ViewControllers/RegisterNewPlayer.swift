//
//  RegisterUsername.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-08.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class RegisterNewPlayer: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var usernameInput: UITextField!
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //add a bottom border and set the placeholder for the username textfield
        usernameInput.setBottomBorder()
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Enter your username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        if defaults.string(forKey: "userName") != nil  {
            performSegue(withIdentifier: "goToHomePage", sender: self)
        }
    }
    
    
    //  =========================================================
    //  Method: registerNewPlayer
    //  Desc:  Set up new Player
    //  Args:   sender
    //  Return: None
    //  =========================================================
    @IBAction func registerNewPlayer(_ sender: Any) {
        
        //register new player to firebase and save defaults
        let ref = Database.database().reference().child("scores")
        ref.childByAutoId().setValue(["userName": usernameInput.text!, "highScore": 0, "totalScore" : 0, "unlockedDarkMode" : false], withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err)
            }
            else
            {
                  //set username, highscore, totalscore, darkmode on register
                let newPlayer =  Player(highScore: 0, totalScore: 0, username: self.usernameInput.text!, fireBaseId : ref.key)
                
                self.defaults.set(newPlayer.username, forKey: "userName")
                self.defaults.set(newPlayer.highScore, forKey: "highScore")
                self.defaults.set(newPlayer.totalScore, forKey: "totalScore")
                self.defaults.set(false, forKey: "unlockDarkMode")
                self.defaults.set(ref.key, forKey: "fireBaseId")
                
                self.performSegue(withIdentifier: "goToHomePage", sender: self)
            }
        
        })
    }
}

extension UITextField {
    
    //  =========================================================
    //  Method: setBottomBorder
    //  Desc: Sets a UITextField bottom border
    //  Args:   None
    //  Return: None
    //  =========================================================
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

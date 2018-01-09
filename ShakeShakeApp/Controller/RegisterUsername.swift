//
//  RegisterUsername.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-08.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class RegisterUsername: UIViewController {
    
    @IBOutlet weak var usernameInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        //add a bottom border and set the placeholder for the username textfield
        usernameInput.setBottomBorder()
        usernameInput.attributedPlaceholder = NSAttributedString(string: "Enter your username", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
   
}

extension UITextField {
    
    //  =========================================================
    //  Method: setBottomBorder
    //  Desc: Method that will give a UITextField bottom border only
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

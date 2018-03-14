//
//  AppDelegate.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-06.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //set up admob
         GADMobileAds.configure(withApplicationID: "ca-app-pub-9390234464100676~9236144580")
        
        
        //set up firebase
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let userDefaults = UserDefaults.standard
        var initalViewController = sb.instantiateViewController(withIdentifier: "MainNavStack")
        
        //if the username is not registered, present the register screen
        if userDefaults.string(forKey: "userName") == nil {
            initalViewController = sb.instantiateViewController(withIdentifier: "RegisterNewPlayer")
        }
        
        window?.rootViewController = initalViewController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    
}


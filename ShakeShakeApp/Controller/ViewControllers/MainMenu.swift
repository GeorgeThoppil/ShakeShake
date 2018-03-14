//
//  MainMenu.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-15.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import GoogleMobileAds

class MainMenu: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var highScore: UITextField!
    @IBOutlet weak var totalScore: UITextField!
    
    let defaults = UserDefaults.standard
    var currentPlayer : Player!
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPlayer = Player(highScore: defaults.integer(forKey: "highScore") , totalScore: defaults.integer(forKey: "totalScore") , username: defaults.string(forKey: "userName")!, fireBaseId : defaults.string(forKey: "fireBaseId")!)
        
        userName.text = currentPlayer.username
        highScore.text = String(currentPlayer.highScore)
        totalScore.text = String(currentPlayer.totalScore)
        
        //implement the banner
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.rootViewController = self
        bannerView.adUnitID = "ca-app-pub-9390234464100676/2751940367"
        addBannerViewToView(bannerView)
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: view.safeAreaLayoutGuide.bottomAnchor,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
    }
    
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "selectInGameShakePic", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {       
       self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectInGameShakePic" {
            
            if let destinationVC = segue.destination as? SelectInGameShakePic {
                destinationVC.currentPlayer = currentPlayer
            }
        }
    }
    
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
}

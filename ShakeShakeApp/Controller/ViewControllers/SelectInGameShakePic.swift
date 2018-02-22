//
//  Settings.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-28.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class SelectInGameShakePic: UIViewController {

  
    var currentPlayer : Player!

    @IBOutlet weak var banana: UIButton!
    @IBOutlet weak var beerBottle: UIButton!
    @IBOutlet weak var shakeWeight: UIButton!
    @IBOutlet weak var darkMode: UIButton!
    @IBOutlet weak var proteinShake: UIButton!
    
    var selectedSkinBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.topItem?.title = "Select Shaker"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGameScreen" {
            
            if let destinationVC = segue.destination as? GameScreen {
                destinationVC.currentPlayer = currentPlayer
            }
        }
    }
    
    func isSkinUnlocked(skinName:String, skinBtn:UIButton) -> Void {
        
        if currentPlayer.isSkinUnlocked(skinName: skinName) {
            
            if selectedSkinBtn != nil {
                selectedSkinBtn.layer.borderWidth = 0
                selectedSkinBtn.layer.borderColor = nil
            }
            skinBtn.layer.borderWidth = 2
            skinBtn.layer.borderColor = UIColor.black.cgColor
            
            selectedSkinBtn = skinBtn
            
        } else {
            let message = "Get over \(GameSettings.unlockSkinPoints[skinName] ?? 0) total points to unlock this item!"
            let alert = UIAlertController(title: "Mystery Item", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func skinBtnClicked (sender: UIButton!)
    {
        switch sender
        {
            case beerBottle:
                isSkinUnlocked(skinName: GameSettings.BEERBOTTLE_CONST, skinBtn : beerBottle)
            case shakeWeight:
                isSkinUnlocked(skinName: GameSettings.SHAKEWEIGHT_CONST, skinBtn : shakeWeight)
            case proteinShake:
                isSkinUnlocked(skinName: GameSettings.PROTEINSHAkE_CONST, skinBtn : proteinShake)
            case darkMode:
                isSkinUnlocked(skinName: GameSettings.DARKMODE_CONST, skinBtn : darkMode)
            default:
                isSkinUnlocked(skinName: GameSettings.BANANA_CONST, skinBtn : banana)
        }
       
    }
}

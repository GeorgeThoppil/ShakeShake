//
//  GameScores.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-20.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import Foundation

struct GameSettings {
    
    static let BANANA_CONST = "banana"
    static let BEERBOTTLE_CONST = "beerBottle"
    static let SHAKEWEIGHT_CONST = "shakeWeight"
    static let PROTEINSHAkE_CONST = "proteinShake"
    static let DARKMODE_CONST = "darkMode"
    
    static let unlockSkinPoints : [String:Int] = [BANANA_CONST: 0,
                                                  BEERBOTTLE_CONST: 1000,
                                                  PROTEINSHAkE_CONST: 4000,
                                                  SHAKEWEIGHT_CONST: 7000,
                                                  DARKMODE_CONST: 10000]
}

//
//  Score.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-01-29.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import Foundation

class Player {
    
    var highScore : Int
    var totalScore : Int
    var username : String
    var inGameScore : Int = 0
    let fireBaseId : String
    var unlockedDarkMode : Bool = false
    
    init(highScore : Int, totalScore : Int, username : String, fireBaseId : String) {
        
        self.highScore = highScore
        self.totalScore = totalScore
        self.username = username
        self.fireBaseId = fireBaseId
    }
}

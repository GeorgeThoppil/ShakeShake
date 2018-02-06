//
//  TopTenScores.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-03.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class TopTenHighScores: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let scoresRef = Database.database().reference(withPath: "scores")
    var topTenPlayerScores = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopTenHighScores()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTenPlayerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath) as! TopTenHighScoresTableViewCell
       if topTenPlayerScores.count > 0
       {
            let player = topTenPlayerScores[indexPath.row]
            cell.username.text = player.username
            cell.rank.text = "#" + String(indexPath.row + 1)
            cell.score.text = String(player.highScore)
       }
        return cell
    }
    
    func getTopTenHighScores() -> Void {
        
        scoresRef.queryOrdered(byChild: "highScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
            if let player = snapShot.value as? [String : AnyObject]
            {
                let playerDetails = Player(highScore: player["highScore"] as! Int, totalScore: player["totalScore"] as! Int, username: player["userName"] as! String, fireBaseId: "")
                self.topTenPlayerScores.append(playerDetails)
                self.topTenPlayerScores.sort(by: { (player1 : Player , player2 : Player) -> Bool in
                    return player1.highScore > player2.highScore
                })
                self.refreshTable()
            }

        }, withCancel: { (err) in
            
        })
    }
    
    func refreshTable() -> Void {
        self.tableView.reloadData()
    }
    
}

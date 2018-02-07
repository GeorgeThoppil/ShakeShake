//
//  TopTenTotalScores.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-03.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit
import Firebase

class TopTenTotalScores: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    let scoresRef = Database.database().reference(withPath: "scores")
      var topTenPlayerScores = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getTopTenTotalScores()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topTenPlayerScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalScoreCell", for: indexPath) as! TopTenTotalScoresTableViewCell
        
        if topTenPlayerScores.count > 0
        {
            let player = topTenPlayerScores[indexPath.row]
            cell.username.text = player.username
            cell.rank.text = "#" + String(indexPath.row + 1)
            cell.totalScore.text = String(player.totalScore)
        }
        return cell
        
    }
    
    func getTopTenTotalScores() -> Void {
        scoresRef.queryOrdered(byChild: "totalScore").queryLimited(toFirst: 10).observe(.childAdded, with: { (snapShot) in
            if let player = snapShot.value as? [String : AnyObject]
            {
                let playerDetails = Player(highScore: player["highScore"] as! Int, totalScore: player["totalScore"] as! Int, username: player["userName"] as! String, fireBaseId: "")
                self.topTenPlayerScores.append(playerDetails)
                self.topTenPlayerScores.sort(by: { (player1 : Player , player2 : Player) -> Bool in
                    return player1.totalScore > player2.totalScore
                })
                self.refreshTable()
            }
            
            
        }, withCancel: { (err) in
            
        })
    }
    
    func refreshTable() -> Void {
        self.tableview.reloadData()
    }
}

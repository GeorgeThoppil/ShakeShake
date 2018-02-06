//
//  TopTenTableViewCell.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-05.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class TopTenHighScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var rank: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

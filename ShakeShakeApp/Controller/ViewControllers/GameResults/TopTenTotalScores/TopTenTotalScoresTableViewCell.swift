//
//  TopTenTotalScoresTableViewCell.swift
//  ShakeShakeApp
//
//  Created by GeorgeT on 2018-02-06.
//  Copyright © 2018 GeorgeT. All rights reserved.
//

import UIKit

class TopTenTotalScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

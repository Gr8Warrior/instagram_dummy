//
//  FeedTableViewCell.swift
//  instagram_sample-Swift
//
//  Created by Shailendra Suriyal on 02/02/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var postedImage: UIImageView!
    
    @IBOutlet var userNameLabel: UILabel!
    
    @IBOutlet var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

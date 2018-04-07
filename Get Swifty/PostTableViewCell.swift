//
//  PostTableViewCell.swift
//  Get Swifty
//
//  Created by Rayan Aldafas on 07/04/2018.
//  Copyright © 2018 Yousef At-tamimi. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionTextView: UITextView!
    @IBOutlet weak var postProfilePic: UIImageView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

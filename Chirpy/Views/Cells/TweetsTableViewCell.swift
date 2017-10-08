//
//  TweetsTableViewCell.swift
//  Chirpy
//
//  Created by Alex Ritchey on 9/25/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

@objc protocol TweetsTableViewCellDelegate {
    @objc optional func tweetCell(tweetCell: TweetsTableViewCell, handleProfileRedirect handle: String)
}

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var timeSince: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!
    @IBOutlet weak var replyIcon: UIImageView!
    
    weak var delegate: TweetsTableViewCellDelegate?
    
    var tweet: Tweet! {
        didSet {
            if let avatarUrl = tweet.avatarUrl {
                avatar.setImageWith(avatarUrl)
            }
            
            fullName.text = tweet.name
            tweetContent.text = tweet.text
            handle.text = tweet.handle
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapAvatar))
            avatar.isUserInteractionEnabled = true
            avatar.addGestureRecognizer(tapGesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onTapAvatar() {
        print("Tapped avatar")
        delegate?.tweetCell!(tweetCell: self, handleProfileRedirect: tweet.handle!)
    }

}

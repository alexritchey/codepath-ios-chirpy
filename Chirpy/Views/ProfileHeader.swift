//
//  ProfileHeader.swift
//  Chirpy
//
//  Created by Alex Ritchey on 10/7/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class ProfileHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var tweetsNumber: UILabel!
    @IBOutlet weak var followersNumber: UILabel!
    @IBOutlet weak var followingNumber: UILabel!
    @IBOutlet weak var bannerImage: UIImageView!
    
    var profileData: Profile? {
        didSet {
            name.text = profileData?.name
            followersNumber.text = profileData?.followersNumber
            tweetsNumber.text = profileData?.tweetsNumber
            followingNumber.text = profileData?.followingNumber
            avatar.setImageWith((profileData?.avatarUrl)!)
            bannerImage.setImageWith((profileData?.bannerUrl)!)
            handle.text = profileData?.handle
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

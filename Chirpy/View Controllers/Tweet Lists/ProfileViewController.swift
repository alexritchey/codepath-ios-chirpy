//
//  ProfileViewController.swift
//  Chirpy
//
//  Created by Alex Ritchey on 10/6/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class ProfileViewController: TweetsViewController {
    
    var handleName: String! {
        didSet {
            getTweets {}
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TwitterClient.sharedInstance.currentAccount(success: { (user: User) in
            
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    override func getTweets(success: @escaping () -> ()) {
        TwitterClient.sharedInstance.profileTimeline(with: handleName, success: { (tweets: [Tweet]) in
            self.tweetList = tweets
            self.tableView.reloadData()
            success()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

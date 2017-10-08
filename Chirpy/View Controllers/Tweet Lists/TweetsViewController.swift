//
//  ViewController.swift
//  Chirpy
//
//  Created by Alex Ritchey on 9/25/17.
//  Copyright © 2017 Alex Ritchey. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, TweetsTableViewCellDelegate {
    
    var tweetList: [Tweet] = []
    var tapGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        refreshControl.addTarget(self, action: #selector(refreshTweets(_:)), for: UIControlEvents.valueChanged)
        
        let cellNib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "TweetCell")
        
        tableView.insertSubview(refreshControl, at: 0)
    }
    
    // Segue to Details
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailsViewController {
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
            let tweet = tweetList[indexPath.row]
            
            vc.tweet = tweet
        } else if let vc = segue.destination as? ComposeTweetViewController {
            
        }
    }
    
    func getTweets(success: @escaping () -> ()) {
        // Pulls home timeline by default
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweetList = tweets
            self.tableView.reloadData()
            success()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
    }
    
    @objc func refreshTweets(_ refreshControl: UIRefreshControl) {
        getTweets {
            refreshControl.endRefreshing()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetsTableViewCell
        
        cell.tweet = tweetList[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func tweetCell(tweetCell: TweetsTableViewCell, handleProfileRedirect handle: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileViewController.handleName = handle
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTapLogout(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
}


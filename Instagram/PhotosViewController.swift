//
//  PhotosViewController.swift
//  Instagram
//
//  Created by Eugenia Leong on 1/28/16.
//  Copyright © 2016 Eugenia Leong. All rights reserved.
//

import UIKit
import AFNetworking

class PhotosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var photos:[NSDictionary]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 320
    
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            //NSLog("response: \(responseDictionary)")
                            self.photos = responseDictionary["data"] as? [NSDictionary]
                            
                            self.tableView.reloadData()
                    }
                }
        });
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        let photo = self.photos![indexPath.section]
        let images = photo["images"]
        let standardImage = images!["standard_resolution"]
        let photoUrl = NSURL(string: standardImage!!["url"] as! String)
        cell.photoView.setImageWithURL(photoUrl!)
        
        return cell
        
    }
        
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        profileView.layer.borderWidth = 1;
        
        // Use the section number to get the right URL
        if let photo = self.photos?[section] {
            let user = photo["user"]
            let profilePictureUrl = NSURL(string: user!["profile_picture"] as! String)
            profileView.setImageWithURL(profilePictureUrl!)
            
            headerView.addSubview(profileView)
            
            // Add a UILabel for the username here
            let usernameLabel = UILabel(frame: CGRectMake(50, 10, 200, 25))
            usernameLabel.text = user!["username"] as? String
            headerView.addSubview(usernameLabel)
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let photos = self.photos {
            return photos.count
        }
        else {
            return 0
        }
    }

}


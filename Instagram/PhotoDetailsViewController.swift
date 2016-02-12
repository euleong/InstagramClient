//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Eugenia Leong on 2/8/16.
//  Copyright © 2016 Eugenia Leong. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var photoUrl:String?
    
    @IBAction func onTap(sender: AnyObject) {
        performSegueWithIdentifier("fullScreenView", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.setImageWithURL(NSURL(string: photoUrl!)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let fullScreenPhotoViewController = segue.destinationViewController as! FullScreenPhotoViewController
        
        fullScreenPhotoViewController.image = self.imageView.image
    }


}

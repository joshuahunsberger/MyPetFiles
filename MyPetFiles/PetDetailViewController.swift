//
//  PetDetailViewController.swift
//  MyPetFiles
//
//  Created by Joshua Hunsberger on 6/4/16.
//  Copyright © 2016 Joshua Hunsberger. All rights reserved.
//

import UIKit

class PetDetailViewController: UIViewController {
    //MARK: Constants
    let SCROLLVIEW_HEIGHT: CGFloat = 225.0
    
    
    // MARK: Properties
    var pet: Pet!
    
    
    // MARK: Interface Builder Outlet Properties
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var photoScrollView: UIScrollView!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        petNameLabel.text = pet.name
        loadPhotos()
    }
    
    
    // MARK: UI setup functions
    
    func loadPhotos() {
        photoScrollView.frame = CGRectMake(0, 0, view.frame.width, SCROLLVIEW_HEIGHT)
        
        let photoCount = pet.largePhotoURLs.count
        photoScrollView.contentSize = CGSizeMake(photoScrollView.frame.width * CGFloat(photoCount), photoScrollView.frame.height)
        photoScrollView.backgroundColor = UIColor.grayColor()
        
        for index in 1...photoCount {
            let imageView = UIImageView(frame: CGRectMake(photoScrollView.frame.width * CGFloat(index-1), 0, photoScrollView.frame.width, photoScrollView.frame.height))
            
            let activityIndicator = UIActivityIndicatorView(frame: imageView.frame)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = .WhiteLarge
            activityIndicator.center = imageView.center
            photoScrollView.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            let url = NSURL(string: pet.largePhotoURLs["\(index)"] as! String)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                let data = NSData(contentsOfURL: url!)!
                let image = UIImage(data: data)
                
                dispatch_async(dispatch_get_main_queue()) {
                    activityIndicator.stopAnimating()
                    imageView.image = image
                    imageView.contentMode = .ScaleAspectFit
                    self.photoScrollView.addSubview(imageView)
                    
                }
            }
        }
    }
}

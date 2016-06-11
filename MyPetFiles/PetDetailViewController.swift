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
    @IBOutlet weak var photoPageControl: UIPageControl!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var breedLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    
    // MARK: View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoScrollView.delegate = self
        
        setupPetDetails()
        loadPhotos()
    }
    
    
    // MARK: UI setup functions
    
    func loadPhotos() {
        photoScrollView.frame = CGRectMake(0, 0, view.frame.width, SCROLLVIEW_HEIGHT)
        
        let photoCount = pet.largePhotoURLs.count
        photoPageControl.numberOfPages = photoCount
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
    
    func setupPetDetails() {
        petNameLabel.text = pet.name
        
        speciesLabel.text = "Species: \(pet.animal)"
        breedLabel.text = "Breed: \(pet.getBreed())"
        sizeLabel.text = "Size: \(pet.size)"
        genderLabel.text = "Gender: \(pet.sex)"
        ageLabel.text = "Age: \(pet.age)"
        
        descriptionTextView.layer.borderColor = UIColor.blackColor().CGColor
        descriptionTextView.layer.borderWidth = 1.0
        descriptionTextView.text = pet.description
        descriptionTextView.scrollRangeToVisible(NSRange(location: 0, length: 0))
    }
}


// MARK: ScrollView Delegate functions

extension PetDetailViewController: UIScrollViewDelegate {
    /** 
        This function updates the page control whenever the scroll view is paged.
     
        Credit to SweetTutos.com for the example of how to use a page control with a scroll view:
        http://sweettutos.com/2015/04/13/how-to-make-a-horizontal-paging-uiscrollview-with-auto-layout-in-storyboards-swift/
    */
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth: CGFloat = CGRectGetWidth(scrollView.frame)
        let currentPage: CGFloat = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1
        
        photoPageControl.currentPage = Int(currentPage)
    }
}

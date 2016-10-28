//
//  DTImageScrollView.swift
//  DTImageScrollView
//
//  Created by Daron Tancharoen on 8/1/16.
//
//

import UIKit
import AlamofireImage

public protocol DTImageScrollViewDatasource: class {
    //func imageForIndex(index:Int) -> UIImage
    func imageURLForIndex(index:Int) -> NSURL
    func numberOfImages() -> Int
}

public class DTImageScrollView: UIView, UIScrollViewDelegate {

    public let scrollView = UIScrollView()
    public let pageControl = UIPageControl()
    public var placeholderImage: UIImage?
    
    public weak var datasource: DTImageScrollViewDatasource?
    
    public func show() {
        setup()
    }
    
    func setup() {
        // add scrollview
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.bounces = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: [], metrics: nil, views: ["view":self.scrollView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: [], metrics: nil, views: ["view":self.scrollView]))
        
        // add page control
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.pageControl)
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .CenterX, relatedBy: .Equal, toItem: self.pageControl, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self, attribute: .Bottom, relatedBy: .Equal, toItem: self.pageControl, attribute: .Bottom, multiplier: 1, constant: 0))
        
        // add photos
        reloadPhotos()
    }
    
    public func reloadPhotos() {
        // remove old ImageViews (if any)
        for view in self.scrollView.subviews {
            view.removeFromSuperview()
        }
        
        // add photos to scrollView
        for index in 0..<self.datasource!.numberOfImages() {
            let imageView = UIImageView()
            imageView.tag = index+1
            imageView.image = self.placeholderImage
            imageView.contentMode = .ScaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = self.placeholderImage
            imageView.af_setImageWithURL(self.datasource!.imageURLForIndex(index))
            self.scrollView.addSubview(imageView)
            
            // add constraints
            // height
            self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Height, relatedBy: .Equal, toItem: imageView, attribute: .Height, multiplier: 1, constant: 0))
            // width
            self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Width, relatedBy: .Equal, toItem: imageView, attribute: .Width, multiplier: 1, constant: 0))
            // top
            self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Top, relatedBy: .Equal, toItem: imageView, attribute: .Top, multiplier: 1, constant: 0))
            // bottom
            self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Bottom, relatedBy: .Equal, toItem: imageView, attribute: .Bottom, multiplier: 1, constant: 0))
            if index == 0 {
                // left to scrollview
                self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Left, relatedBy: .Equal, toItem: imageView, attribute: .Left, multiplier: 1, constant: 0))
            } else {
                // left to right of previous view
                let previouseImageView = self.viewWithTag(index)!
                self.scrollView.addConstraint(NSLayoutConstraint(item: previouseImageView, attribute: .Right, relatedBy: .Equal, toItem: imageView, attribute: .Left, multiplier: 1, constant: 0))
            }
            if index == self.datasource!.numberOfImages()-1 {
                // right to scrollview
                self.scrollView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .Right, relatedBy: .Equal, toItem: imageView, attribute: .Right, multiplier: 1, constant: 0))
            }
        }
        
        // update page control
        self.pageControl.numberOfPages = self.datasource!.numberOfImages()
        self.pageControl.currentPage = 0
        
        // layoutIfNeeded()
    }
    
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // update pageController
        let pageWidth = scrollView.frame.size.width
        let fractionalPage = Float(scrollView.contentOffset.x / pageWidth)
        let page = Int(roundf(fractionalPage))
        self.pageControl.currentPage = page
    }
}



//
//  ViewController.swift
//  DTImageScrollViewDemo
//
//  Created by Daron Tancharoen on 8/1/16.
//
//

import UIKit

class ViewController: UIViewController, DTImageScrollViewDatasource {

    @IBOutlet weak var imageScrollView: DTImageScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.imageScrollView.datasource = self
        self.imageScrollView.show()
    }

    func numberOfImages() -> Int {
        return 3
    }
    
    func imageURL(index: Int) -> URL {
        return URL(string: "http://www.boxzeed.com/wp-content/uploads/2015/09/1.1.3.jpg")!
    }
    
    func placeholderImageFor(index:Int) -> UIImage {
        if index == 0 {
            return UIImage(named: "sample")!
        } else {
            return UIImage(named: "placeholder3")!
        }
    }
}


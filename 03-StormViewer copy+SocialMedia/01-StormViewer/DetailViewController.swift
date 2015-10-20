//
//  DetailViewController.swift
//  01-StormViewer
//
//  Created by Laura Calinoiu on 19/10/15.
//  Copyright © 2015 3Smurfs. All rights reserved.
//

import UIKit
import Social

class DetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!

    var detailItem: String? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let imageView = self.detailImageView {
                imageView.image = UIImage(named: detail)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "shareTapped")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    
    func shareTapped(){
//        let activity = UIActivityViewController(activityItems: [detailImageView.image!], applicationActivities: [])
//        presentViewController(activity, animated: true, completion: nil)
        let social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        social.setInitialText("Hello world, buy my app!")
        social.addImage(detailImageView.image)
        social.addURL(NSURL(string: "www.gov"))
        presentViewController(social, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


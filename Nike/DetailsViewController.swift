//
//  DetailsViewController.swift
//  Nike
//
//  Created by Aparna Revu on 2/2/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var selectedImageView: UIImageView!
    var selectedImageURL: String = ""
    var selectedUser: String = ""
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = self.selectedUser
        
        let appDelegate = AppDelegate.shared()
        appDelegate.requestDownloadImageForURL(imageUrlStr:self.selectedImageURL) { (image) in
            
            DispatchQueue.main.async{
              self.selectedImageView.image = image
            }
            
        }
    }
    
    /* UTILITY METHODS */
    @IBAction func doneButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

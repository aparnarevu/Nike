//
//  HomeViewController.swift
//  Nike
//
//  Created by Aparna Revu on 2/2/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController,UIGestureRecognizerDelegate,ProductCellDelegate {

    var productsList = [Any]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Nike"

        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateWithJsonData(_:)), name: Notification.Name.myNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let delegate = AppDelegate.shared()
        self.productsList = AppDelegate.shared().productsList

        DispatchQueue.main.async{
            self.tableView.reloadData()
        }

        
    }
    
    /* TABLEVIEW DATASOURCE METHODS */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductTableViewCell? = (tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as? ProductTableViewCell)
        
        cell?.delegate = self
        let productDetailsList = productsList[indexPath.row] as! [AnyHashable : Any]
        cell?.loadPhotoDetails(productDetailsList)
        
        return cell!
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    
    /* UTILITY METHODS */

 
    func tappedCellDelegate(recognizer:UIGestureRecognizer) {
        
        if recognizer.state == UIGestureRecognizerState.ended {
            let tapLocation = recognizer.location(in: self.tableView)
            if let tapedIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
                
                let detailsView = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                
                var productDetailsDict: [AnyHashable: Any] = productsList[tapedIndexPath.row] as! [AnyHashable : Any]
                
                let imagesList = productDetailsDict[kImagesKey] as! [Any]
                
                let thumbImage = imagesList[0] as! [AnyHashable : Any]
                
                detailsView.selectedImageURL = (thumbImage[kImagePathKey] as! String?)!
                detailsView.selectedUser = (productDetailsDict[kNameKey] as! String?)!
                self.present(detailsView, animated: true, completion: nil)
            }
        }

    }

    func updateWithJsonData(_ notification: Notification) {
        
        if self.productsList.count > 0 {
            self.productsList.removeAll()
        }
        
        self.productsList = AppDelegate.shared().productsList
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }

}

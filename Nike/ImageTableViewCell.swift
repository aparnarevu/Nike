//
//  ImageTableViewCell.swift
//  Nike
//
//  Created by Aparna Revu on 2/2/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

protocol ProductCellDelegate {
    func tappedCellDelegate(recognizer:UIGestureRecognizer)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    var delegate: ProductCellDelegate?

    override func awakeFromNib() {
        self.thumbImageView.image = UIImage(named: "balls_loading.gif")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tap(sender:)))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)

    }

    /* UTILITY METHODS */
    func tap(sender: UITapGestureRecognizer) {
        delegate?.tappedCellDelegate(recognizer: sender)
        
    }

    func loadPhotoDetails(_ productDetailsDict: [AnyHashable: Any]) {

        self.titleLabel?.text = productDetailsDict[kNameKey] as! String?
        self.colorLabel?.text = productDetailsDict[kColorCodeKey] as! String?
        let pricesList = productDetailsDict[kPriceListKey] as! [AnyHashable: Any]

        self.priceLabel?.text = pricesList[kPriceKey] as! String?

        let appDelegate = AppDelegate.shared()
        let imagesList = productDetailsDict[kImagesKey] as! [Any]

        let thumbImage = imagesList[1] as! [AnyHashable : Any]
        
        appDelegate.requestDownloadImageForURL(imageUrlStr: (thumbImage[kImagePathKey] as! String?)!) { (image) in
            DispatchQueue.main.async{
             self.thumbImageView.image = image
            }

        }
    }


}

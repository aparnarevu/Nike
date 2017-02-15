//
//  Constants.swift
//  ImageLoader
//
//  Created by Aparna Revu on 2/2/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import Foundation

    public let kTitleKey: String = ""
    
    public let kLoadingImagesAPI: String = "https://api.myjson.com/bins/1ejwdh"
    //http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    public let kResultsKey: String = "results"
    public let kProductsKey: String = "products"

    public let kNameKey: String = "name1"
    public let kImagesKey: String = "images"
    public let kImagePathKey: String = "path"

    public let kColorCodeKey: String = "colorCode"
    public let kPriceKey: String = "formattedCurrentRetail"
    public let kPriceListKey: String = "prices"



extension Notification.Name {
    public static let myNotification = Notification.Name(rawValue: "jsonNotification")
}

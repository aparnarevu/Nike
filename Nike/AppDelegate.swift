//
//  AppDelegate.swift
//  Nike
//
//  Created by Aparna Revu on 2/2/17.
//  Copyright © 2017 Aparna Revu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var productsList = [AnyObject]()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        productListFromContentsOfFileWithName(fileName: "productList")
        //loadNikeProductsData(urlStr: kLoadingImagesAPI)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Loading the products from text file
    func productListFromContentsOfFileWithName(fileName: String){
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)

            let parsedData = convertToDictionary(text: content)
            
            //For Loading Products
            let resultsList = parsedData?[kResultsKey] as! [AnyObject]
            
            //FOR LOADING PRODUCTS
            self.productsList = resultsList[0][kProductsKey] as! [AnyObject]
            
            //Posting Notification
            NotificationCenter.default.post(name: Notification.Name.myNotification, object: nil, userInfo: nil)

        } catch {
            print(error.localizedDescription)
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    
    //Loading the products from URL
    func loadNikeProductsData(urlStr:String)-> Void {
        
        
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    
                    //For Loading Products
                    let resultsList = parsedData[kResultsKey] as! [AnyObject]
                    
                    //FOR LOADING PRODUCTS
                    self.productsList = resultsList[0][kProductsKey] as! [AnyObject]
                    
                    //Posting Notification
                    NotificationCenter.default.post(name: Notification.Name.myNotification, object: nil, userInfo: nil)
                    
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()
        
    }
    
    //Downloading the Image
    func requestDownloadImageForURL(imageUrlStr:String, completion: @escaping ((_ image: UIImage) -> Void)) {
        // the data was received and parsed to String
        let thumbImageURL = URL(string: imageUrlStr)!
        
        let session = URLSession(configuration: .default)
        
        // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
        let downloadPicTask = session.dataTask(with: thumbImageURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading image: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded image with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        completion(image!)
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
        
        
    }
    
    class func shared() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }

}


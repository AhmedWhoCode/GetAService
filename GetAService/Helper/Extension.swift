//
//  Extension.swift
//  GetAService
//
//  Created by Geek on 26/02/2021.
//

import UIKit

class ImageCache: NSObject , NSDiscardableContent {
    public var image: UIImage!

    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {

    }

    func discardContentIfPossible() {

    }

    func isContentDiscarded() -> Bool {
        return false
    }
    
}

let imageCache = NSCache<NSString , ImageCache>()

extension UIImageView{
    
    func loadCacheImage(with imageRefURL:String)
    {
        if let cachImage = imageCache.object(forKey: imageRefURL as NSString){
            
            print("from cache")
            self.image = cachImage.image
            
            return
        }
        
        let imageUrl = URL(string: imageRefURL)
        print("from internet")

        //download image from the internet using thread
        URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let e = error{
                print(e)
            }else{
                
            //Setting image using main thread
                DispatchQueue.main.async() { [weak self] in
                    
                    if let downloadImage = UIImage(data: data!){
                        let cacheImage = ImageCache()
                        cacheImage.image = downloadImage
                        //self.cache.setObject(cacheImage, forKey: "somekey" as NSString)
                        imageCache.setObject(cacheImage, forKey: imageRefURL as NSString)
                        
                        //checking if the imageView is loaded or not
                        if self?.image != nil
                        {
                        self!.image = downloadImage
                        }
                    }
                    
                }
                
            }
        }.resume()
    }
    
    
    
}

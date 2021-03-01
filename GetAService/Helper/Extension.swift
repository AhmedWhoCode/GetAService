//
//  Extension.swift
//  GetAService
//
//  Created by Geek on 26/02/2021.
//

import UIKit


let imageCache = NSCache<NSString , UIImage>()

extension UIImageView{
    
    func loadCacheImage(with imageRefURL:String)
    {
        if let cachImage = imageCache.object(forKey: imageRefURL as NSString){
            
            self.image = cachImage
            
            return
        }
        
        let imageUrl = URL(string: imageRefURL)
        
        //download image from the internet using thread
        let task  = URLSession.shared.dataTask(with: imageUrl!) { (data, response, error) in
            
            if let e = error{
                print(e)
            }else{
                
            //Setting image using main thread
                DispatchQueue.main.async() { [weak self] in
                    
                    if let downloadImage = UIImage(data: data!){
                        
                        imageCache.setObject(downloadImage, forKey: imageRefURL as NSString)
                        
                        self!.image = downloadImage
                    }
                    
                }
                
            }
        }.resume()
    }
    
    
    
}

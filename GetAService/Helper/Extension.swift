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
    
    func loadCacheImage(with imageRefURL:String , completion:@escaping () ->() = {})
    {
        if let cachImage = imageCache.object(forKey: imageRefURL as NSString){
            
            print("from cache")
            self.image = cachImage.image
            
            return
        }
        
        let imageUrl = URL(string: imageRefURL)

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
                            completion()
                        }
                    }
                    
                }
                
            }
        }.resume()
    }
    
    
    
}


func showInputDialog(
                     viewController : UIViewController,
                     title:String? = nil,
                     subtitle:String? = nil,
                     actionTitle:String? = "Add",
                     cancelTitle:String? = "Cancel",
                     inputPlaceholder:String? = nil,
                     inputKeyboardType:UIKeyboardType = UIKeyboardType.default,
                     cancelHandler: ((UIAlertAction) -> Swift.Void)? = nil,
                     actionHandler: ((_ text: String?) -> Void)? = nil) {
    
    let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
    alert.addTextField { (textField:UITextField) in
        textField.placeholder = inputPlaceholder
        textField.keyboardType = inputKeyboardType
    }
    alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
        guard let textField =  alert.textFields?.first else {
            actionHandler?(nil)
            return
        }
        actionHandler?(textField.text)
    }))
    alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
    
    viewController.present(alert, animated: true, completion: nil)
}



//convert date to local time
extension Date
{
    func convertDateToLocalTime() -> String{
        let dateString = DateFormatter.localizedString(
            from: self ,
            dateStyle: .medium,
            timeStyle: .medium)
        
        return dateString

    }
    
}

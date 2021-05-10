//
//  AcceptOrDecline.swift
//  GetAService
//
//  Created by Geek on 01/02/2021.
//

import UIKit
import SwiftyGif
class AcceptOrDecline: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       designingView()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Calling database functions
    
    //MARK: - Local functions
    
    //MARK: - Onclick functions
    
    //MARK: - Ovveriden functions
    
    //MARK: - Misc functions
    
    
    func designingView() {
        
        //Showing gif to imageView
        do
        {
        let gif = try UIImage(gifName:Constants.gifNames.greenCheckGif)
        imageView.setGifImage(gif, loopCount: -1)
        }
        
        catch
        {
            
        }
        
        rejectButton.layer.cornerRadius = 25
        rejectButton.layer.borderWidth = 1
        rejectButton.layer.borderColor = UIColor.black.cgColor
        
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.black.cgColor
        
        
    }

}

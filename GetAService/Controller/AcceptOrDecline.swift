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
    //@IBOutlet weak var //animateView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
       designingView()
        
        // Do any additional setup after loading the view.
    }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

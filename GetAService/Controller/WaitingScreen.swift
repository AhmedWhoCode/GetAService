//
//  WaitingScreen.swift
//  GetAService
//
//  Created by Geek on 02/02/2021.
//

import UIKit

class WaitingScreen: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        do
        {
            let gif = try UIImage(gifName: Constants.gifNames.inProgressGif)
        imageView.setGifImage(gif, loopCount: -1)
        }
        catch
        {
            
        }
           
        // Do any additional setup after loading the view.
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

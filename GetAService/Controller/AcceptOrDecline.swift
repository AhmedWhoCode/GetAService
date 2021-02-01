//
//  AcceptOrDecline.swift
//  GetAService
//
//  Created by Geek on 01/02/2021.
//

import UIKit
//import Lottie
class AcceptOrDecline: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    //@IBOutlet weak var //animateView: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
       designingView()
        
        // Do any additional setup after loading the view.
    }
    func designingView() {
        
//        animateView.contentMode = .scaleAspectFit
//          
//          // 2. Set animation loop mode
//          
//        animateView.loopMode = .loop
//          
//          // 3. Adjust animation speed
//          
//        animateView.animationSpeed = 0.5
//          
//          // 4. Play animation
//        animateView.play()
        
        
        
        
        
        
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

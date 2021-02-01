//
//  AcceptOrDecline.swift
//  GetAService
//
//  Created by Geek on 01/02/2021.
//

import UIKit

class AcceptOrDecline: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
       designingView()
        
        // Do any additional setup after loading the view.
    }
    func designingView() {
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

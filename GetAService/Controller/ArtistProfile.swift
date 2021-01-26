//
//  ArtistProfile.swift
//  GetAService
//
//  Created by Geek on 26/01/2021.
//

import UIKit

class ArtistProfile: UIViewController {

    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        designingView()
        // Do any additional setup after loading the view.
    }
    
    func designingView() {
        ///MARK: - designing views
        submitButton.layer.cornerRadius = 20
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
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

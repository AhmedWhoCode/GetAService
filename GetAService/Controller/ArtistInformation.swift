//
//  ArtistInformationViewController.swift
//  GetAService
//
//  Created by Geek on 23/01/2021.
//

import UIKit

class ArtistInformation: UIViewController {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    
    @IBOutlet weak var bookNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designingViews()
        // Do any additional setup after loading the view.
    }
    
    func designingViews(){
        ///MARK: - designing views
        countryView.layer.cornerRadius = 15
        countryView.layer.borderWidth = 1
        countryView.layer.borderColor = UIColor.black.cgColor
        
        priceView.layer.cornerRadius = 15
        priceView.layer.borderWidth = 1
        priceView.layer.borderColor = UIColor.black.cgColor
        
        statusView.layer.cornerRadius = 15
        statusView.layer.borderWidth = 1
        statusView.layer.borderColor = UIColor.black.cgColor
        
        bookNowButton.layer.cornerRadius = 20
        bookNowButton.layer.borderWidth = 1
        bookNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
         artistImage.layer.cornerRadius = artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
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

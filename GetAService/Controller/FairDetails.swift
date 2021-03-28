//
//  FairDetailsViewController.swift
//  GetAService
//
//  Created by Geek on 24/01/2021.
//

import UIKit
import CoreLocation


//protocol FairDetailsDelegate
//{
//    func buyerDidConfirm()
//}


class FairDetails: UIViewController {

    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var ModelPriceView: UIView!
    @IBOutlet weak var estimatedPriceView: UIView!
    @IBOutlet weak var uberFairView: UIView!
    @IBOutlet weak var confirmBooking: UIButton!
    
    
    @IBOutlet weak var uberEstimatedLabel: UILabel!
    @IBOutlet weak var modelPriceLabel: UILabel!
    @IBOutlet weak var totalEstimatedLabel: UILabel!


    
    var buyerId : String?
    var sellerId : String?
 
    //var fairDetailDelegate : FairDetailsDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buyerId = BookingBrain.sharedInstance.buyerId
        sellerId = BookingBrain.sharedInstance.sellerId
        
        // changing this varible to allow proceed button work
        BookingBrain.sharedInstance.check = true
 
        
        BookingBrain.sharedInstance.gettingSellerLocation(with: buyerId!, sellerId: sellerId!) { (lat, long, address,price) in
            //converting seller lat, lon to double
            let sellerLat = Double(lat)
            let sellerLong = Double (long)
            
            //converting buyer lat, lon to double
            let buyerLat = Double(BookingBrain.sharedInstance.buyerLatitude!)
            let buyerLong = Double (BookingBrain.sharedInstance.buyerLongitude!)
            

             //setting lat long values
            let sellerCoordinates =  CLLocation(latitude: sellerLat!, longitude: sellerLong!)
            let buyerCoordinates =   CLLocation(latitude: buyerLat!, longitude: buyerLong!)

           //getting distance
            let distance = buyerCoordinates.distance(from: sellerCoordinates) / 1000
            
            self.uberEstimatedLabel.text = String(format: "%.1f", distance) + " KM"
            self.modelPriceLabel.text = price
            self.totalEstimatedLabel.text = address
            


        }

        designingView()
        // Do any additional setup after loading the view.
    }
    
    func designingView() {
        navigationItem.hidesBackButton = false
        ///MARK: - designing views
        ModelPriceView.layer.cornerRadius = 15
        ModelPriceView.layer.borderWidth = 1
        ModelPriceView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        estimatedPriceView.layer.cornerRadius = 15
        estimatedPriceView.layer.borderWidth = 1
        estimatedPriceView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        uberFairView.layer.cornerRadius = 15
        uberFairView.layer.borderWidth = 1
        uberFairView.layer.borderColor = UIColor.black.cgColor
        
        ///MARK: - designing views
        confirmBooking.layer.cornerRadius = 20
        confirmBooking.layer.borderWidth = 1
        confirmBooking.layer.borderColor = UIColor.black.cgColor
        
        artistImage.layer.masksToBounds = true
        artistImage.layer.borderColor = UIColor.black.cgColor
        artistImage.layer.cornerRadius=artistImage.frame.size.height/2
        artistImage.contentMode = .scaleAspectFill
        
    }

    @IBAction func startServicePressed(_ sender: UIButton) {
        
       // fairDetailDelegate?.buyerDidConfirm()
        BookingBrain.sharedInstance.updateAcknowledgeStatus(value: "started") {
            print("why")
            self.performSegue(withIdentifier: Constants.seguesNames.locationInfoToStarted, sender:  nil)
        }
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

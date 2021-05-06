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

    @IBOutlet weak var sellerImage: UIImageView!
    @IBOutlet weak var ModelPriceView: UIView!
    @IBOutlet weak var estimatedPriceView: UIView!
    @IBOutlet weak var uberFairView: UIView!
    @IBOutlet weak var confirmBooking: UIButton!
    @IBOutlet weak var sellerName: UILabel!
    
    
    @IBOutlet weak var uberEstimatedLabel: UILabel!
    @IBOutlet weak var sellerPriceLabel: UILabel!
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

           //getting distance in meters and converting to miles
            let distance = buyerCoordinates.distance(from: sellerCoordinates) / 1609.344
            
            self.uberEstimatedLabel.text = String(format: "%.1f", distance) + "Mi"
            self.sellerPriceLabel.text = price
            self.totalEstimatedLabel.text = address
            self.sellerImage.loadCacheImage(with: BookingBrain.sharedInstance.sellerImage!)
            self.sellerName.text = BookingBrain.sharedInstance.sellerName!


        }

        designingView()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isToolbarHidden = true
        navigationItem.hidesBackButton = false
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
        
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
        sellerImage.layer.cornerRadius=sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
        
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

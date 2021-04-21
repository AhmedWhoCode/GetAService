//
//  GoogleMapViewController.swift
//  GetAService
//
//  Created by Geek on 16/03/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
class GoogleMapViewController: UIViewController, BookingBrainDelegate{
    
    
    
    var bookingModel : BookingModel?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var searchPressed: UIButton!
    @IBOutlet weak var proceedButton: UIButton!
    
    var autocompleteController : GMSAutocompleteViewController?
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    
    //if the control is coming from seller side
    var isSellerASourceVc = false
    var notificationId : String?
    var buyerId : String?
    var bookingStatus : String?
    var notificationBrain  = NotificationBrain()
    var sellerPriceUpdated : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //autocomplete view controll initilized
        autocompleteController = GMSAutocompleteViewController()
        
        //track the location changes
        locationManager.delegate = self
        
        BookingBrain.sharedInstance.bookingBrainDelegate = self
        
        designView()
        
        GoogleMapBrain.sharedInstance.updateCurrentLocationOnMap(with: locationManager, mapView: mapView) 
        
    }
    
    
    func didSendTheBookingDetails() {
        
        performSegue(withIdentifier:Constants.seguesNames.locationToWaiting, sender: self)
    }
    
    //these are the optional method, not needed
    func didSellerRespond(result: String){}
    func didAcknowledgementChange(result: String) {}
    
    
    @IBAction func proceedButton(_ sender: UIButton) {
        
        sender.isUserInteractionEnabled = false
        
        if isSellerASourceVc
        {
            //BookingBrain.sharedInstance.sellerCoordinates = locationManager.location?.coordinate
            
            guard let latitude = locationManager.location?.coordinate.latitude.description else {
                return
            }
            guard let longitude = locationManager.location?.coordinate.longitude.description else {
                return
            }
            guard let address = addressLabel.text else {
                return
            }
    
            notificationBrain.updateBookingStatus(with: "accepted",
                                                  buyerId: buyerId!,
                                                  notificationId:notificationId!,
                                                  sellerLatitude: latitude,
                                                  sellerLongitude: longitude,
                                                  sellerAddress: address,
                                                  sellerUpdatedPrice: sellerPriceUpdated!
                                                                   )
            performSegue(withIdentifier: Constants.seguesNames.mapsToSellerWaiting, sender: self)
        }
        
        else
        
        {
            print("buyer")
            if let booking = bookingModel
            {
                BookingBrain.sharedInstance.insertBookingInfomationToFirebase(with: booking)
                
                let sender = PushNotificationSender()
                sender.sendPushNotification(to: BookingBrain.sharedInstance.sellerTokenId!, title: "You have a booking", body: "kindly open an app")
            }
        }
    }
    
    
    
    @IBAction func getLocation(_ sender: UIButton) {
        // to know the selected location of user
        autocompleteController!.delegate = self
        
        presentAutoComplete()
        
    }
    
    //converting coordinates into address
    func reverseGeocode(with location: CLLocation) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(location.coordinate) { response, error in
            guard
                let address = response?.firstResult(),
                let lines = address.lines
            else {
                return
            }
            
            self.addressLabel.text = lines.joined()
            
            //calling method to update location to be send to firebase
            
            self.updatingLocation(with: lines.joined(), coordinates: location.coordinate)
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func presentAutoComplete() {
        
        
        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue:UInt(GMSPlaceField.name.rawValue) |
                                                    UInt(GMSPlaceField.placeID.rawValue) |
                                                    UInt(GMSPlaceField.coordinate.rawValue) |
                                                    GMSPlaceField.addressComponents.rawValue |
                                                    GMSPlaceField.formattedAddress.rawValue)
        autocompleteController!.placeFields = fields
        
        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController!.autocompleteFilter = filter
        
        // Display the autocomplete view controller.
        present(autocompleteController!, animated: true, completion: nil)
        
    }
    
    
    func designView() {
        if isSellerASourceVc{
            searchPressed.isHidden = true
        }
        
        proceedButton.layer.cornerRadius = 25
        proceedButton.layer.borderWidth = 1
        proceedButton.layer.borderColor = UIColor.black.cgColor
        
        
        searchPressed.layer.cornerRadius = 25
        searchPressed.layer.borderWidth = 1
        searchPressed.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func updatingLocation(with address : String , coordinates  : CLLocationCoordinate2D) {
        
        let locationModel = LocationModel(address: address, coordinates: coordinates)
        bookingModel?.eventLocation = locationModel
        
        //print("2ndTime \(bookingModel.unsafelyUnwrapped)")
    }
    
}


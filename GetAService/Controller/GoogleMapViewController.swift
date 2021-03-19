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
class GoogleMapViewController: UIViewController{
    
    var notificationModel : NotificationModel?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBOutlet weak var searchPressed: UIButton!
    
    @IBOutlet weak var proceedButton: UIButton!
    
    var autocompleteController : GMSAutocompleteViewController?
    
    @IBOutlet weak var addressLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
    
    var locationAddress : String?
    
    var locationCoordinates : CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //autocomplete view controll initilized
        autocompleteController = GMSAutocompleteViewController()
        
        //track the location changes
        locationManager.delegate = self
        
        designView()
        
        GoogleMapBrain.sharedInstance.updateCurrentLocationOnMap(with: locationManager, mapView: mapView) ///updateCurrentLocationOnMap()
        
        print("n1 \(notificationModel)")
        
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
        //        presentingViewController?.present(autocompleteController, animated: true, completion: nil)
        present(autocompleteController!, animated: true, completion: nil)
        
    }
    
    //    func updateCurrentLocationOnMap() {
    //        //updating maps with current location
    //        if CLLocationManager.locationServicesEnabled() {
    //            locationManager.requestLocation()
    //
    //            mapView.isMyLocationEnabled = true
    //            mapView.settings.myLocationButton = true
    //        } else {
    //            locationManager.requestWhenInUseAuthorization()
    //        }
    //    }
    
    func designView() {
        
        proceedButton.layer.cornerRadius = 25
        proceedButton.layer.borderWidth = 1
        proceedButton.layer.borderColor = UIColor.black.cgColor
        
        
        searchPressed.layer.cornerRadius = 25
        searchPressed.layer.borderWidth = 1
        searchPressed.layer.borderColor = UIColor.black.cgColor
    }
    
    
    func updatingLocation(with address : String , coordinates  : CLLocationCoordinate2D) {
        
        let locationModel = LocationModel(address: address, coordinates: coordinates)
        notificationModel?.eventLocation = locationModel
        
        print("2ndTime \(notificationModel.unsafelyUnwrapped)")
    }
}


//// MARK: - CLLocationManagerDelegate
////1
//extension GoogleMapViewController: CLLocationManagerDelegate {
//    // 2
//    func locationManager(
//        _ manager: CLLocationManager,
//        didChangeAuthorization status: CLAuthorizationStatus
//    ) {
//
//        guard status == .authorizedWhenInUse else {
//            return
//        }
//
//        locationManager.requestLocation()
//
//
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
//        mapView.mapType = .terrain
//    }
//
//    func locationManager(
//        _ manager: CLLocationManager,
//        didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else {
//            return
//        }
//        // convert coordinates into actual address
//        reverseGeocode(coordinate: location.coordinate)
//        mapView.camera = GMSCameraPosition(
//            target: location.coordinate,
//            zoom: 15,
//            bearing: 0,
//            viewingAngle: 0)
//    }
//
//    func locationManager(
//        _ manager: CLLocationManager,
//        didFailWithError error: Error
//    ) {
//        print(error)
//    }
//}
//
//
//extension GoogleMapViewController: GMSAutocompleteViewControllerDelegate {
//
//    // Handle the user's selection.
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//
//
//        //show the selected place in maps
//        let position = place.coordinate
//        let marker = GMSMarker(position: position)
//        marker.title = place.name
//        marker.map = mapView
//        mapView.camera = GMSCameraPosition(
//            target: position,
//            zoom: 20,
//            bearing: 0,
//            viewingAngle: 0)
//        addressLabel.text = place.formattedAddress
//
//
//        dismiss(animated: true, completion: nil)
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//
//    // User canceled the operation.
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//
//    // Turn the network activity indicator on and off again.
//    //  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    //    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    //  }
//    //
//    //  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
//    //    UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    //  }
//
//}

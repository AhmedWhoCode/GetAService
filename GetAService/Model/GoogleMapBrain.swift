//
//  GoogleMapBrain.swift
//  GetAService
//
//  Created by Geek on 18/03/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GoogleMapBrain {
      static let sharedInstance = GoogleMapBrain()
    
    
    func updateCurrentLocationOnMap(with locationManager : CLLocationManager, mapView: GMSMapView) {
        //updating maps with current location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
            
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
   

}

// MARK: - CLLocationManagerDelegate
//1
extension GoogleMapViewController: CLLocationManagerDelegate {
    // 2
    func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        
        guard status == .authorizedWhenInUse else {
            return
        }
       
        locationManager.requestLocation()
        
       
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.mapType = .terrain
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
    
        // convert coordinates into actual address
        reverseGeocode(with: location)
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 15,
            bearing: 0,
            viewingAngle: 0)
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print(error)
    }
}


extension GoogleMapViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        
        //show the selected place in maps
        let position = place.coordinate
        let marker = GMSMarker(position: position)
        marker.title = place.name
        marker.map = mapView
        mapView.camera = GMSCameraPosition(
            target: position,
            zoom: 20,
            bearing: 0,
            viewingAngle: 0)
        addressLabel.text = place.formattedAddress
        
        //calling method to update location to be send to firebase
        updatingLocation(with: place.formattedAddress ?? "No address found", coordinates: position)
        
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    //  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    //  }
    //
    //  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    //    UIApplication.shared.isNetworkActivityIndicatorVisible = false
    //  }
    
}

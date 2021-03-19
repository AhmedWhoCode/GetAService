//
//  LocationManager.swift
//  GetAService
//
//  Created by Geek on 16/03/2021.
//

import Foundation
import CoreLocation


struct Location {
    let title : String
    let coordinates :  CLLocationCoordinate2D?
}


class LocationManager: NSObject {
    static let shared = LocationManager()
     let geoCoding = CLGeocoder()
    func findLocation(with query : String ,completion:@escaping ([Location]) -> ()){
        print("plz")
        geoCoding.geocodeAddressString(query) { (places, error) in
            if let place = places
            {

                let model : [Location] = place.compactMap { (data) -> Location in
                    var name = ""
                    
                    if let locationName = data.name
                    {
                        name += locationName
                    }
                    
                    if let locality = data.locality
                    {
                        name += ", \(locality)"
                    }
                    if let country = data.country
                    {
                        name += ", \(country)"
                    }
                    
                    let result = Location(title: name , coordinates: data.location?.coordinate)
                    
                    return result
                    
                }
                
                completion(model)
                
            }
            else
            {
                completion([])
            }
            
        }
        //to be code
    }
    
}

//
//  ServicesBrain.swift
//  GetAService
//
//  Created by Geek on 21/02/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase

// defining a protocol
protocol DataManipulation {
    func didReceiveData(with data:[ServicesModel])
}

class ServicesBrain {
    static let cache = NSCache<NSString , UIImage>()

    var urlString = [String]()
    var dataManipulationDelegant:DataManipulation?
    
    let db = Firestore.firestore()
    
    var servicesData = [ServicesModel]()
    var subServices = [String]()
    
    func retrivingServicesFromDatabase() {
        
        
        db.collection("Categories").getDocuments { (snapShot, error) in
            if let snap = snapShot?.documents
            {
                let totalServices = snap.count - 1
                
                for i in 0...totalServices
                {
                    //getting service name
                    let serviceName = snap[i].documentID
                    let serviceImage = snap[i].data()["ImageRef"]
                    //passing data to servicemodel class
                    let services = ServicesModel(serviceName: serviceName, serviceImage: serviceImage as! String)
                   // adding data to service class
                    self.servicesData.append(services)
                }
                 // calling this method when the data is added to array and sending it to services viewController
                self.dataManipulationDelegant?.didReceiveData(with: self.servicesData)
            }
            
        }
    }

    
    func retrivingSubServicesFromDatabase(with category : String , completion : @escaping ([String])->()) {
        
        db.collection("Categories").document(category).collection("SubCategories").getDocuments
        { (snapShot, error) in
            
            if let snap = snapShot?.documents
            {
                let total = snap.count - 1
                for i in 0...total
                {
                    self.subServices.append(snap[i].documentID)
                }
                completion(self.subServices)
            }
            
        }
        
    }
}

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

    
    var dataManipulationDelegant:DataManipulation?
    
    let db = Firestore.firestore()
    
    var servicesData = [ServicesModel]()
    
    func retrivingServicesFromDatabase() {
        
        db.collection("Categories").getDocuments { (snapShot, error) in
            if let snap = snapShot?.documents
            {
                let totalServices = snap.count - 1
                
                for i in 0...totalServices
                {
                    //getting service name
                    let serviceName = snap[i].documentID
                    
                    //getting  of image stored as a imagref in firestore and converting to url
                    let serviceImage = URL(string: snap[i].data()["ImageRef"] as! String)!
                    // converting url to data
                    let data = try? Data(contentsOf: serviceImage)
                    // converting data into the ui image
                    let image: UIImage = UIImage(data: data!)!
                    //passing data to servicemodel class
                    let services = ServicesModel(serviceName: serviceName, serviceImage: image)
                   // adding data to service class
                    self.servicesData.append(services)
                }
                 // calling this method when the data is added to array and sending it to services viewController
                    self.dataManipulationDelegant?.didReceiveData(with: self.servicesData)
            }
            
        }
    }
    
    func retrivingSubServicesFromDatabase(with category : String) {
        db.collection("Categories").document(category).collection("SubCategories").getDocuments
        { (snapShot, error) in
            
            if let snap = snapShot?.documents
            {
                var total = snap.count - 1
                for i in 0...total
                {
                    print(snap[i].documentID)
                }
            }
            
        }
        
    }
}

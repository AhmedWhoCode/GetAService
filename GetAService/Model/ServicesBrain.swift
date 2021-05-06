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
    
    
    var selectedSubServices = [String]()
    var selectedSubSerWithPrice = [String:String]()

    
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
                    let services = ServicesModel(serviceName: serviceName, serviceImage: serviceImage as? String)
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
    
    
    func retrieveSelectedSubservices(completion :@escaping ([String]) -> ()) {
        
        db.collection("UserProfileData").document("Seller").collection("AllSellers").document(Auth.auth().currentUser!.uid).addSnapshotListener { (snapShot, error) in
            
            if let e = error
            {
                print(e.localizedDescription)
            }
            else
            {
                if let snap = snapShot?.data()
                {
                    
                    if let subServices = snap["SubServices"]
                    {
                        self.selectedSubServices = subServices as! [String]
                        completion(self.selectedSubServices)
                    }
                    
                }
            }
        }
        
    }
    
    
    func retrieveSelectedSubservicesWithPrice(
        
        
        using userId : String = Auth.auth().currentUser!.uid ,
        completion :@escaping ([String:String]) ->())
    
    {
        db.collection("UserProfileData")
            .document("Seller")
            .collection("AllSellers")
            .document(userId)
            .collection("subservices")
            .getDocuments { (snapshot, error) in
                
                if let e = error
                {
                    print("error while retriving selectedsubservices with price:" , e.localizedDescription)
                }
                else
                {
                    if let snap = snapshot
                    {
                        
                        for doc in snap.documents
                        {
                         
                            self.selectedSubSerWithPrice[doc.documentID] = doc.data()["price"] as? String
                            
                        }                        
                        completion(self.selectedSubSerWithPrice)
                        
                    }
                    
                }
                
            }
        
    }
    
    func retrieveSubservicesWithPriceForPublicProfile(
                                                    with sellerId : String
                                                    ,subservices: [String]
                                                    ,completion :@escaping ([String:String]) -> ()
    )
        {
        retrieveSelectedSubservicesWithPrice(using: sellerId) { (subservicesWithPrice) in
            
            var updatedSubserviceWithPrice = [String:String]()
            
            for service in subservices
            {
                if let price = subservicesWithPrice[service]
                {
                    updatedSubserviceWithPrice[service] = price
                }
                
            }
            print("yahoo" , updatedSubserviceWithPrice)
            completion(updatedSubserviceWithPrice)
        }
    }
}

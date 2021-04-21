//
//  Helper Functions.swift
//  GetAService
//
//  Created by Geek on 13/03/2021.
//

import Foundation
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Firebase

var currentUser = Auth.auth().currentUser?.uid
let db = Firestore.firestore()

func isUserSellerOrBuyer(userID : String,completion :@escaping (String) ->()) {
    
    
    
    //var id = Auth.auth().currentUser!.uid
    db.collection("isUserOrNil").document(userID).getDocument { (snapShot, error) in
        
        if let snap = snapShot?.data()
        {
            //getting profile info if an id is of seller
            if snap["UserType"]! as! String == "Seller"
            {
                
                completion("seller")
                
            }
            
            else
            {
                completion("buyer")
                
            }
            
        }
        else
        {
            completion("No data")
        }
    }
}

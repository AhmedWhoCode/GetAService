//
//  SellerProfileModel.swift
//  GetAService
//
//  Created by Geek on 20/02/2021.
//

import Foundation

struct SellerProfileModel {
   var uid:String
   var imageRef:String
   var name:String
   var email:String
   var state:String
   var phone:String
   var price:String
   var service:String
   var city:String
   var description:String
   var dob:Date
   var gender:String
   var document:String
   var documentName:String

}

struct SellerRetrievalReviewsModel {
    var star : String
    var comment : String
}

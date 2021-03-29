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
   var address:String
   var phone:String
   var price:String
   var service:String
   var country:String
   var description:String
   var dob:Date
   var gender:String

}

struct SellerRetrievalReviewsModel {
    var star : String
    var comment : String
}

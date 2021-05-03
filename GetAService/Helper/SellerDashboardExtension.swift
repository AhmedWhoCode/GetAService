//
//  SellerDashboardExtension.swift
//  GetAService
//
//  Created by Geek on 03/04/2021.
//

import Foundation
import UIKit

extension SellerDashboardViewController
{
    
    func designingViews(){
        navigationController?.isToolbarHidden = false
        navigationController?.isNavigationBarHidden = false
//        subService1.isHidden = true
//        subService2.isHidden = true
//        subService3.isHidden = true
//        subService4.isHidden = true
//        subService5.isHidden = true
//        subService6.isHidden = true
        
        
        navigationItem.hidesBackButton = true
        ///MARK: - designing views
        countryView.layer.cornerRadius = 15
        countryView.layer.borderWidth = 0.3
        countryView.layer.borderColor = UIColor.black.cgColor
        
        priceView.layer.cornerRadius = 15
        priceView.layer.borderWidth = 0.3
        priceView.layer.borderColor = UIColor.black.cgColor
        
        statusView.layer.cornerRadius = 15
        statusView.layer.borderWidth = 0.3
        statusView.layer.borderColor = UIColor.black.cgColor
//        
//        
//        subService1.layer.cornerRadius = 10
//        subService1.layer.borderWidth = 0.3
//        subService1.layer.borderColor = UIColor.black.cgColor
//        
//        ////        subService1.layer.shadowColor = UIColor.blue.cgColor
//        ////        subService1.layer.shadowOpacity = 0.5
//        ////        subService1.layer.shadowOffset = CGSize.zero
//        //     subService1.layer.shadowRadius = 10
//        
//        
//        subService2.layer.cornerRadius = 10
//        subService2.layer.borderWidth = 0.3
//        subService2.layer.borderColor = UIColor.black.cgColor
//        
//        
//        subService3.layer.cornerRadius = 10
//        subService3.layer.borderWidth = 0.3
//        subService3.layer.borderColor = UIColor.black.cgColor
//        
//        subService4.layer.cornerRadius = 10
//        subService4.layer.borderWidth = 0.3
//        subService4.layer.borderColor = UIColor.black.cgColor
//        
//        subService5.layer.cornerRadius = 10
//        subService5.layer.borderWidth = 0.3
//        subService5.layer.borderColor = UIColor.black.cgColor
//        
//        subService6.layer.cornerRadius = 10
//        subService6.layer.borderWidth = 0.3
//        subService6.layer.borderColor = UIColor.black.cgColor
        
        
        //        bookNowButton.layer.cornerRadius = 20
        //        bookNowButton.layer.borderWidth = 1
        //        bookNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
        sellerImage.layer.cornerRadius = sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
    }
}

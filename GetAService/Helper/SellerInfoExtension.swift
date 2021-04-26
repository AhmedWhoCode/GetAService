//
//  SellerInfoExtension.swift
//  GetAService
//
//  Created by Geek on 03/04/2021.
//

import UIKit

extension SellerInformation
{
    
    func designingViews(){
        //designing collection view
        collectionView.layer.cornerRadius = 10
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor =  UIColor.black.cgColor
        
        navigationItem.hidesBackButton = false
        
//        subService1.isHidden = true
//        subService2.isHidden = true
//        subService3.isHidden = true
//        subService4.isHidden = true
//        subService5.isHidden = true
//        subService6.isHidden = true
        
        ///MARK: - designing views
        countryView.layer.cornerRadius = 15
        countryView.layer.borderWidth = 1
        countryView.layer.borderColor = UIColor.black.cgColor
        
        priceView.layer.cornerRadius = 15
        priceView.layer.borderWidth = 1
        priceView.layer.borderColor = UIColor.black.cgColor
        
        statusView.layer.cornerRadius = 15
        statusView.layer.borderWidth = 1
        statusView.layer.borderColor = UIColor.black.cgColor
        
        
        
//        subService1.layer.cornerRadius = 10
//        subService1.layer.borderWidth = 1
//        subService1.layer.borderColor = UIColor.black.cgColor
//        
//        
//        
//        subService2.layer.cornerRadius = 10
//        subService2.layer.borderWidth = 1
//        subService2.layer.borderColor = UIColor.black.cgColor
//        
//        
//        subService3.layer.cornerRadius = 10
//        subService3.layer.borderWidth = 1
//        subService3.layer.borderColor = UIColor.black.cgColor
//        
//        subService4.layer.cornerRadius = 10
//        subService4.layer.borderWidth = 1
//        subService4.layer.borderColor = UIColor.black.cgColor
//        
//        subService5.layer.cornerRadius = 10
//        subService5.layer.borderWidth = 1
//        subService5.layer.borderColor = UIColor.black.cgColor
//        
//        subService6.layer.cornerRadius = 10
//        subService6.layer.borderWidth = 1
//        subService6.layer.borderColor = UIColor.black.cgColor
        
        bookNowButton.layer.cornerRadius = 20
        bookNowButton.layer.borderWidth = 1
        bookNowButton.layer.borderColor = UIColor.black.cgColor
        
        
        sellerImage.layer.masksToBounds = true
        sellerImage.layer.borderColor = UIColor.black.cgColor
         sellerImage.layer.cornerRadius = sellerImage.frame.size.height/2
        sellerImage.contentMode = .scaleAspectFill
    }
}

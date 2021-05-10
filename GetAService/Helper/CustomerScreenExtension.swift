//
//  CustomerScreenExtension.swift
//  GetAService
//
//  Created by Geek on 23/03/2021.
//

import UIKit

extension BuyerRequestScreen
{

    
    func desigingView(){
        
        
        //hides back button of top navigation
        navigationItem.hidesBackButton = false

        //MARK: - adding roundness to image
        buyerImageImageView.layer.masksToBounds = true
        buyerImageImageView.layer.borderWidth = 1
        buyerImageImageView.layer.borderColor = UIColor.black.cgColor
        buyerImageImageView.layer.cornerRadius = buyerImageImageView.frame.size.height/2
        buyerImageImageView.contentMode = .scaleAspectFill
        
        //MARK: - adding shadow to info view
        buyerInfoView.layer.cornerRadius = 10
        buyerInfoView.layer.shadowColor = UIColor.black.cgColor
        buyerInfoView.layer.shadowOpacity = 1
        buyerInfoView.layer.shadowRadius = 10
        
        //MARK: -making views round
//      locationView.layer.cornerRadius = 25
//        locationView.layer.borderWidth = 0.5
//        locationView.layer.borderColor = UIColor.black.cgColor
        
        //MARK: - adding shadow to info view
        locationView.layer.cornerRadius = 10
        locationView.layer.shadowColor = UIColor.black.cgColor
        locationView.layer.shadowOpacity = 1
        locationView.layer.shadowRadius = 10
        
        //MARK: -making views round
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.borderColor = UIColor.black.cgColor
        
        
//        changeLocationButton.layer.cornerRadius = 25
//        changeLocationButton.layer.borderWidth = 1
//        changeLocationButton.layer.borderColor = UIColor.black.cgColor
        
        
        rejectButton.layer.cornerRadius = 25
        rejectButton.layer.borderWidth = 1
        rejectButton.layer.borderColor = UIColor.black.cgColor
        
        

    }
  
}

//
//  ShowToast.swift
//  GetAService
//
//  Created by Geek on 02/03/2021.
//

import Foundation
import UIKit

func showToast1(controller: UIViewController, message : String, seconds: Double,color :UIColor) {
    let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
    alert.view.backgroundColor = color
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15

    controller.present(alert, animated: true)

    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
        alert.dismiss(animated: true)
       
    }
    
}

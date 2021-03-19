//
//  ButtonPressed.swift
//  GetAService
//
//  Created by Geek on 04/02/2021.
//

import Foundation
import UIKit
import CoreLocation

 protocol ButtonPressed {
    
    func didButtonPressed(with value : String)
}

protocol ButtonPressed2 {
   
   func didButtonPressed(with button : UIButton)
}



//
//  PlaceModel.swift
//  TravelBook
//
//  Created by Hayrullah Faruk KARAŞIN on 23.03.2022.
//

import Foundation
import UIKit


class PlaceModel{
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var description = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    
    private init(){}
    
}


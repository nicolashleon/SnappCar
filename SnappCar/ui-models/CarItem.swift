//
//  CarItem.swift
//  SnappCar
//
//  Created by Nicolas Hurtado on 7/26/19.
//  Copyright © 2019 CarShare. All rights reserved.
//

import Foundation
struct CarItem {
    let name : String
    let userPictureUrl : String?
    let price : String
    let rating : Double?
    let reviewCount : Int
    let carPictureUrl : String?
    let location : String
    
    init(_ name : String, _ userPictureUrl : String? = nil, _ price : String, _ rating : Double? = nil,
         _ reviewCount : Int, _ carPictureUrl : String? = nil, _ location : String) {
        self.name = name
        self.userPictureUrl = userPictureUrl
        self.price = price
        self.rating = rating
        self.reviewCount = reviewCount
        self.carPictureUrl = carPictureUrl
        self.location = location
    }

}

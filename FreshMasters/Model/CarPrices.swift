//
//  CarPrices.swift
//  FreshMasters
//
//  Created by John Crawford on 3/22/21.
//

import SwiftUI

final class CarPrices: Prices {
    
    var interior: Double = 99
    var exterior: Double = 99
    var full: Double = 179
    var paintGlaze: Double = 39
    var paintPolish: Double = 349
    
    override init(){
        super.init(
            interiorDetail: interior,
            exteriorDetail: exterior,
            fullDetail: full,
            glaze: paintGlaze,
            polish: paintPolish
        )
    }
    
}

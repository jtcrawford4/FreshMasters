//
//  CarPrices.swift
//  FreshMasters
//
//  Created by John Crawford on 3/22/21.
//

import SwiftUI

final class CarPrices: Prices {
    
    var interior: Double = 100
    var exterior: Double = 101
    var full: Double = 200
    var paintGlaze: Double = 50
    var paintPolish: Double = 399
    
    init(){
        super.init(
            interiorDetail: interior,
            exteriorDetail: exterior,
            fullDetail: full,
            glaze: paintGlaze,
            polish: paintPolish
        )
    }
    
}

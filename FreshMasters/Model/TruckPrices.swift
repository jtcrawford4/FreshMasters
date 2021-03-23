//
//  TruckPrices.swift
//  FreshMasters
//
//  Created by John Crawford on 3/23/21.
//

import SwiftUI

final class TruckPrices: Prices {
    
    var interior: Double = 99
    var exterior: Double = 149
    var full: Double = 229
    var paintGlaze: Double = 49
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

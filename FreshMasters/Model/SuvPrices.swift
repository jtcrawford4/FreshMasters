//
//  SuvPrices.swift
//  FreshMasters
//
//  Created by John Crawford on 3/23/21.
//

final class SuvPrices: Prices {
    
    var interior: Double = 149
    var exterior: Double = 149
    var full: Double = 275
    var paintGlaze: Double = 49
    var paintPolish: Double = 499
    
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

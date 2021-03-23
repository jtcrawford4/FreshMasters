//
//  Prices.swift
//  FreshMasters
//
//  Created by John Crawford on 3/22/21.
//

//MARK: - ideally get pricing info from db somewhere, but until then this is how it be :shrugs
import SwiftUI

class Prices{
    
    var interiorDetail: Double = 0
    var exteriorDetail: Double = 0
    var fullDetail: Double = 0
    
    let headlightRestoration: Double = 79.99
    var glaze: Double = 0
    let engine: Double = 69.99
    var polish: Double = 0
    
    init(interiorDetail: Double, exteriorDetail: Double, fullDetail: Double, glaze: Double, polish: Double){
        self.interiorDetail = interiorDetail
        self.exteriorDetail = exteriorDetail
        self.fullDetail = fullDetail
        self.glaze = glaze
        self.polish = polish
    }
    
    func getTotalPrice() -> Double{
        headlightRestoration + engine
    }
    
    //MARK: - reference only. delete
//    let carInterior: Double = 0
//    let carExterior: Double = 0
//    let carFull: Double = 0
//
//    let truckInterior: Double = 0
//    let truckExterior: Double = 0
//    let truckFull: Double = 0
//
//    let vanInterior: Double = 0
//    let vanExterior: Double = 0
//    let vanFull: Double = 0
//
//    let suvInterior: Double = 0
//    let suvExterior: Double = 0
//    let suvFull: Double = 0
    
//    let headlightRestoration: Double = 79.99
//    let glaze: Double = 49.99
//    let engine: Double = 69.99
//    let polish: Double = 399
    
//    var totalPrice: Double = 0
    
    
}

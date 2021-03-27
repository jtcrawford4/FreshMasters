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
    
    var mileage: Double = 0
    
    init(){
        self.interiorDetail = 0
        self.exteriorDetail = 0
        self.fullDetail = 0
        self.glaze = 0
        self.polish = 0
    }
    
    init(interiorDetail: Double, exteriorDetail: Double, fullDetail: Double, glaze: Double, polish: Double){
        self.interiorDetail = interiorDetail
        self.exteriorDetail = exteriorDetail
        self.fullDetail = fullDetail
        self.glaze = glaze
        self.polish = polish
    }
    
    func calculateMileageCost(milesToCustomer: Double){
        self.mileage = 25.00
    }
    
}

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
    
    var milesToCustomer: Double = 0
    var mileageSurcharge: Double = 0
    
    var yearSurcharge: Double = 0
    var yearSurchargePercentage: Float = 15
    
    init(){
        self.interiorDetail = 0
        self.exteriorDetail = 0
        self.fullDetail = 0
        self.glaze = 0
        self.polish = 0
        self.mileageSurcharge = 0
    }
    
    init(interiorDetail: Double, exteriorDetail: Double, fullDetail: Double, glaze: Double, polish: Double){
        self.interiorDetail = interiorDetail
        self.exteriorDetail = exteriorDetail
        self.fullDetail = fullDetail
        self.glaze = glaze
        self.polish = polish
    }
    
    func vehicleHasAgeSurcharge(year: String) -> Bool{
        if (year.isEmpty){
            return false
        }
        let currentYear = Calendar.current.component(.year, from: Date())
        let vehicleYear = Int(year) ?? 0
        return (currentYear - vehicleYear > 6)
    }
    
    func calculateAgeSurcharge(totalPrice: Double) -> Double{
        let surcharge = totalPrice * Double((self.yearSurchargePercentage / 100))
        self.yearSurcharge = surcharge
        return surcharge
    }
    
    func calculateMileageCost(milesToCustomer: Double){
        switch milesToCustomer{
            case 0..<10:
                self.mileageSurcharge = 0
            case 10..<15:
                self.mileageSurcharge = 19.99
            case 15..<20:
                self.mileageSurcharge = 24.99
            case 20..<25:
                self.mileageSurcharge = 29.99
            case 25..<30:
                self.mileageSurcharge = 34.99
            case 30..<40:
                self.mileageSurcharge = 39.99
            case 40..<50:
                self.mileageSurcharge = 49.99
            case 50..<60:
                self.mileageSurcharge = 59.99
            case 60...:
                self.mileageSurcharge = -1
            default:
                self.mileageSurcharge = 0
        }
    }
    
    func submitPromoCode(code: String) -> Bool {
        print("testing promo code")
        return true
    }
    
}

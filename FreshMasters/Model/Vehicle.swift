//
//  Vehicle.swift
//  FreshMasters
//
//  Created by John Crawford on 3/22/21.
//

import SwiftUI

final class Vehicle: ObservableObject{
    
    @Published var vehicleType = vehicleTypes.def.rawValue
    @Published var serviceType = serviceTypes.def.rawValue
    @Published var year = ""
    @Published var make = ""
    @Published var model = ""
    @Published var polish = false
    @Published var headlightRestore = false
    @Published var glaze = false
    @Published var engine = false
    @Published var mobileService = false
    @Published var hasAgeSurcharge = false
    @Published var hasValidPromoCode = false
    @Published var totalPrice: Double = 0
    
    var prices =  Prices()
    var hours = Hours()
    
    func getTotalPrice() -> Double{
        hasValidPromoCode = prices.hasValidPromoCode
        hours.additionalHours = 0
        var total = 0.00
        var ageSurcharge = 0.00
        total += getServiceTypePrice(service: serviceTypes(rawValue: self.serviceType)!)
        if (polish){
            total += prices.polish
            hours.addAdditionalHours(hours: 4)
        }
        if (headlightRestore){
            total += prices.headlightRestoration
            hours.addAdditionalHours(hours: 1)
        }
        if (glaze){
            total += prices.glaze
            hours.addAdditionalHours(hours: 2)
        }
        if (engine){
            total += prices.engine
            hours.addAdditionalHours(hours: 1)
        }

        total += mobileService ? prices.mileageSurcharge : 0
        
        if (hasAgeSurcharge){
            ageSurcharge = prices.calculateAgeSurcharge(totalPrice: total)
            total += ageSurcharge
        }

        if(hasValidPromoCode){
            total -= mobileService ? prices.mileageSurcharge : 0
            total -= hasAgeSurcharge ? ageSurcharge : 0
        }
        return total
    }
    
    func getServiceTypePrice(service: serviceTypes) -> Double{
        switch service {
        case serviceTypes.exterior:
            return prices.exteriorDetail
        case serviceTypes.interior:
            return prices.interiorDetail
        case serviceTypes.full:
            return prices.fullDetail
        case serviceTypes.def:
            return 0.00
        }
    }
    
    func getYearMakeModel() -> String{
        "\(self.year) \(self.make) \(self.model)"
    }
    
    func isValidYearMakeModel() -> VehicleValidation{
        if(!isValidYear(year: self.year)){
            return .invalidYear
        }
        if(self.make.isEmpty){
            return .invalidMake
        }
        if(self.model.isEmpty){
            return .invalidModel
        }
        return .valid
    }
    
    func isValidYear(year: String) -> Bool{
        if (year.count == 4 && year.isNumeric){
            let yearInt = Int(year)!
            let currentYear = Calendar.current.component(.year, from: Date())
            let maxModelYear = currentYear + 1
            if (1900 <= yearInt && yearInt <= maxModelYear){
                return true
            }else{
                return false
            }
        }
        return false
    }
    
    enum vehicleTypes: String{
        case car = "Car"
        case truck = "Truck"
        case van = "Van"
        case suv = "SUV"
        case def = ""
    }

    enum serviceTypes: String{
        case exterior = "Exterior Detail"
        case interior = "Interior Detail"
        case full = "Full Detail"
        case def = ""
    }
    
}

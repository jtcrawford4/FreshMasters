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
    
    var prices =  Prices()
    var hours = Hours()
    var totalPrice: Double = 0
    
    func getTotalPrice() -> Double{
        var total = 0.00
        total += getServiceTypePrice(service: serviceTypes(rawValue: self.serviceType)!)
        total += polish ? prices.polish : 0
        total += headlightRestore ? prices.headlightRestoration : 0
        total += glaze ? prices.glaze : 0
        total += engine ? prices.engine : 0
        total += mobileService ? prices.mileage : 0
        total += hasAgeSurcharge ? prices.calculateAgeSurcharge(totalPrice: total) : 0
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

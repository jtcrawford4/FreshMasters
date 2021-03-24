//
//  Vehicle.swift
//  FreshMasters
//
//  Created by John Crawford on 3/22/21.
//

import SwiftUI

final class Vehicle: ObservableObject{
    
    @Published var vehicleType = ""
    @Published var serviceType = ""
    @Published var year = ""
    @Published var make = ""
    @Published var model = ""
    @Published var polish = false
    @Published var headlightRestore = false
    @Published var glaze = false
    @Published var engine = false
    
    var prices =  Prices()
    var totalPrice: Double = 0
    
    func getTotalPrice() -> Double{
        var total = 0.00
        total += getServiceTypePrice(service: serviceTypes(rawValue: self.serviceType)!)
        total += polish ? prices.polish : 0
        total += headlightRestore ? prices.headlightRestoration : 0
        total += glaze ? prices.glaze : 0
        total += engine ? prices.engine : 0
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
        }
    }
    
    func getYearMakeModel() -> String{
        "\(self.year) \(self.make) \(self.model)"
    }
    
    enum vehicleType: String{
        case car = "Car"
        case truck = "Truck"
        case van = "Van"
        case suv = "SUV"
    }

    enum serviceTypes: String{
        case exterior = "Exterior Detail"
        case interior = "Interior Detail"
        case full = "Full Detail"
    }
}



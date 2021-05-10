//
//  Order.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

final class Order: ObservableObject{
    
    var vehicle = Vehicle()
    var customer = Customer()
        
    func sampleOrder() -> Order{
        let order = Order()
        let vehicle = Vehicle()
        vehicle.prices = CarPrices()
        vehicle.prices.hasValidPromoCode = true
        vehicle.prices.promoCode = "devtestonly"
        vehicle.engine = true
        vehicle.glaze = true
        vehicle.hasAgeSurcharge = true
        vehicle.mobileService = true
        vehicle.polish = true
        vehicle.headlightRestore = true
        vehicle.serviceType = Vehicle.serviceTypes.full.rawValue
        vehicle.year = "2005"
        vehicle.make = "Chevrolet"
        vehicle.model = "Corvette"
        order.vehicle = vehicle
        order.vehicle.hours.setBaseHours(vehicleType: Vehicle.vehicleTypes(rawValue: "Car")!,
                                         serviceType: Vehicle.serviceTypes(rawValue: "Full Detail")!)
        return order
    }
}

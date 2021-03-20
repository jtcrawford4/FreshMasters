//
//  Order.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

final class Order: ObservableObject{
    
    @Published var vehicleType = ""
    @Published var serviceType = ""
    @Published var polish = false
    @Published var headlightRestore = false
    @Published var glaze = false
    @Published var engine = false
    
    // better way
//    @Published var vehicle: Vehicle()
    
}
//class car extends vehicle and has a service type, reads from prices class, etc
//final class Vehicle: ObservableObject{
//
//    @Published var
//
//}

enum vehicleType: String{
    case car = "Car"
    case truck = "Truck"
    case van = "Van"
    case suv = "SUV"
}

enum serviceType: String{
    case exterior = "Exterior"
    case interior = "Interior"
    case full = "Full"
}

//enum vehicleType2: Double{
//    case car
//}

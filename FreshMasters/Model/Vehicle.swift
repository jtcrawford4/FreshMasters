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
    @Published var polish = false
    @Published var headlightRestore = false
    @Published var glaze = false
    @Published var engine = false
    
    //MARK: - create prices object when selected?
    enum vehicleType: String{
        case car = "Car"
        case truck = "Truck"
        case van = "Van"
        case suv = "SUV"
    }

    enum serviceType: String{
        case exterior = "Exterior Detail"
        case interior = "Interior Detail"
        case full = "Full Detail"
    }
}



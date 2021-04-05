//
//  Hours.swift
//  FreshMasters
//
//  Created by John Crawford on 4/4/21.
//

import SwiftUI

class Hours: ObservableObject{
 
    @Published var baseHoursLow: Int = 0
    @Published var baseHoursHigh: Int = 0
    @Published var additionalHours: Int = 0
    @Published var totalHours: Int = 0
    
    func setBaseHours(vehicleType: Vehicle.vehicleTypes, serviceType: Vehicle.serviceTypes){
        switch vehicleType{
        case .car:
            switch serviceType{
                case .interior:
                    baseHoursLow = 3
                    baseHoursHigh = 4
                case .exterior:
                    baseHoursLow = 3
                    baseHoursHigh = 4
                case.full:
                    baseHoursLow = 6
                    baseHoursHigh = 8
                case.def:
                    baseHoursLow = 0
                    baseHoursHigh = 0
            }
        case .truck:
            switch serviceType{
                case .interior:
                    baseHoursLow = 3
                    baseHoursHigh = 4
                case .exterior:
                    baseHoursLow = 4
                    baseHoursHigh = 5
                case.full:
                    baseHoursLow = 7
                    baseHoursHigh = 9
                case.def:
                    baseHoursLow = 0
                    baseHoursHigh = 0
            }
        case .van:
            switch serviceType{
                case .interior:
                    baseHoursLow = 4
                    baseHoursHigh = 5
                case .exterior:
                    baseHoursLow = 4
                    baseHoursHigh = 5
                case.full:
                    baseHoursLow = 8
                    baseHoursHigh = 10
                case.def:
                    baseHoursLow = 0
                    baseHoursHigh = 0
            }
        case .suv:
            switch serviceType{
                case .interior:
                    baseHoursLow = 4
                    baseHoursHigh = 5
                case .exterior:
                    baseHoursLow = 4
                    baseHoursHigh = 5
                case.full:
                    baseHoursLow = 8
                    baseHoursHigh = 10
                case.def:
                    baseHoursLow = 0
                    baseHoursHigh = 0
            }
        case .def:
            baseHoursLow = 0
            baseHoursHigh = 0
        }
    }
    
    func addAdditionalHours(hours: Int){
        additionalHours += hours
    }
    
    func getTotalHoursLow() -> Int{
        return baseHoursLow + additionalHours
    }
    
    func getTotalHoursHigh() -> Int{
        return baseHoursHigh + additionalHours
    }
    
}

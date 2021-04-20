//
//  VehicleValidation.swift
//  FreshMasters
//
//  Created by John Crawford on 4/19/21.
//

import Foundation

enum VehicleValidation: Error{
    case valid
    case invalidYear
    case invalidMake
    case invalidModel
}

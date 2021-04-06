//
//  FmError.swift
//  FreshMasters
//
//  Created by John Crawford on 3/31/21.
//

import SwiftUI

enum FmError: Error{
    case invalidAddress
    case invalidStreetCityZip
    case invalidCityZip
    case invalidCoordinate
    case outsideServiceArea
    case unknown
}

//
//  Alert.swift
//  FreshMasters
//
//  Created by John Crawford on 3/31/21.
//

import SwiftUI

struct AlertItem: Identifiable{
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext{
    static let invalidAddress = AlertItem(title: Text("Invalid Address"), message: Text("All address fields must be provided"), dismissButton: .default(Text("OK")))
    
    static let invalidStreetCityZip = AlertItem(title: Text("Invalid Address"), message: Text("Street address, city, and zip code combination not valid"), dismissButton: .default(Text("OK")))
    
    static let invalidCityZip = AlertItem(title: Text("Invalid Address"), message: Text("City and zip code combination not valid"), dismissButton: .default(Text("OK")))
    
    static let outsideServiceArea = AlertItem(title: Text("Outside of Service Area"), message: Text("The location provided is outside of the available service area. Please contact FreshMasters for special accommodations."), dismissButton: .default(Text("OK")))
    
    static let invalidCoordinate = AlertItem(title: Text("Invalid Address"), message: Text("Address provided could not be found"), dismissButton: .default(Text("OK")))
    
    static let unknown = AlertItem(title: Text("System Error"), message: Text("Unexpected error occurred"), dismissButton: .default(Text("OK")))
}
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
    
    static let pennsylvania = AlertItem(title: Text("Nice try Harrison"), message: Text("You really tried this one again huh?"), dismissButton: .default(Text("OK")))
    
    static let invalidCoordinate = AlertItem(title: Text("Invalid Address"), message: Text("Address provided could not be found"), dismissButton: .default(Text("OK")))
    
    static let unknown = AlertItem(title: Text("System Error"), message: Text("Unexpected error occurred"), dismissButton: .default(Text("OK")))
    
    static let emailFailure = AlertItem(title: Text("System Error"), message: Text("Appointment could not be sent. Please try again later or contact FreshMasters support at drivingfresh@gmail.com to complete appointment."), dismissButton: .default(Text("OK")))
    
    static let invalidAppointmentForm = AlertItem(title: Text("Appointment Error"), message: Text("First and last name required."), dismissButton: .default(Text("OK")))
    
    static let missingPhoneEmail = AlertItem(title: Text("Appointment Error"), message: Text("Phone number or email required."), dismissButton: .default(Text("OK")))
    
    static let invalidEmail = AlertItem(title: Text("Appointment Error"), message: Text("Invalid email format."), dismissButton: .default(Text("OK")))
    
    static let invalidPhone = AlertItem(title: Text("Appointment Error"), message: Text("Invalid phone number."), dismissButton: .default(Text("OK")))
    
    static let invalidYear = AlertItem(title: Text("Invalid Year"), message: Text("Please enter a valid 4 digit vehicle year."), dismissButton: .default(Text("OK")))
    
    static let invalidMake = AlertItem(title: Text("Invalid Make"), message: Text("Make must not be empty."), dismissButton: .default(Text("OK")))
    
    static let invalidModel = AlertItem(title: Text("Invalid Model"), message: Text("Model must not be empty."), dismissButton: .default(Text("OK")))
}

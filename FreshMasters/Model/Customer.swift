//
//  Customer.swift
//  FreshMasters
//
//  Created by John Crawford on 3/21/21.
//

import SwiftUI

final class Customer: ObservableObject{
    @Published var address = Address()
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var appointmentDate = Date()
    @Published var contactByEmail = false
    @Published var contactByPhone = false
    @Published var contactByText = false
    @Published var mobileService = false
}

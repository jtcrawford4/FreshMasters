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
    @Published var appointmentDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @Published var contactByEmail = false
    @Published var contactByPhone = false
    @Published var contactByText = false
    
    func isValidForm() -> Bool{
        if(!self.firstName.isEmpty && !self.lastName.isEmpty){
            if(self.email.isEmpty && !self.phone.isEmpty){
                return true
            }
            else if (!self.email.isEmpty && isValidEmail(emailAddress: self.email)){
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    private func isValidEmail(emailAddress: String) -> Bool{
        let emailFormat         = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate      = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: emailAddress)
    }
    
}

//
//  FormError.swift
//  FreshMasters
//
//  Created by John Crawford on 4/11/21.
//

import SwiftUI

enum FormValidation: Error{
    case valid
    case invalidForm
    case invalidEmail
    case invalidPhoneEmail
}

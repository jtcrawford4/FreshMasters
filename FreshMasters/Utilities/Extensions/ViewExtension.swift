//
//  ViewExtension.swift
//  FreshMasters
//
//  Created by John Crawford on 4/26/21.
//

import SwiftUI

extension View{
    
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}

//
//  FreshMastersApp.swift
//  FreshMasters
//
//  Created by John Crawford on 3/15/21.
//

import SwiftUI



@main
struct FreshMastersApp: App {
    
    var order = Order()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}

//
//  AppointmentConfirmationView.swift
//  FreshMasters
//
//  Created by John Crawford on 4/1/21.
//

import SwiftUI

struct AppointmentConfirmationView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        //MARK: - add reminder option
        //MARK: - calendar icon, big number of date
        VStack{
            AppointmentCalendar(date: order.customer.appointmentDate)
        }
//        ZStack{
//            Image(systemName: "calendar")
//                .resizable()
//                .frame(width: 60, height: 60)
//            Text("24")
//        }
    }
}

struct AppointmentConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentConfirmationView()
            .environmentObject(Order())
    }
}

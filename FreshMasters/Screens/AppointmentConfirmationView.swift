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
        
        ZStack{

            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.background, Color.backgroundShadow]), startPoint: .bottomTrailing, endPoint: .topLeading))
                .ignoresSafeArea()
        
            VStack{
                TitleText(text: "Appointment Confirmed")
                    .font(.system(size: 65))
                AppointmentCalendar(date: order.customer.appointmentDate)
                    .padding(.bottom, 40)
                
                Button(action: {
                    //MARK: - add function/permissions
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                }, label: {
                    VStack{
                        Image(systemName: "deskclock")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding()
                    }
                    .foregroundColor(.white)
                })
                .frame(width: 60, height: 60)
                .background(Color.green)
                .clipShape(Circle())
                
                Text("Set Reminder")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
            }

        }
    }
}

struct AppointmentConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentConfirmationView()
            .environmentObject(Order())
    }
}

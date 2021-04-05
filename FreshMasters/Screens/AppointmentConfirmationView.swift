//
//  AppointmentConfirmationView.swift
//  FreshMasters
//
//  Created by John Crawford on 4/1/21.
//

import SwiftUI

struct AppointmentConfirmationView: View {
    
    @EnvironmentObject var order: Order
    @Binding var showingModal: Bool
    @State var showingReminderNotification = false
    
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
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    addReminder(title: "FreshMasters detailing appointment today", note: "\(order.vehicle.year) \(order.vehicle.make) \(order.vehicle.model), \(order.vehicle.serviceType)",
                                date: order.customer.appointmentDate)
                    showingReminderNotification.toggle()
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
                .alert(isPresented: $showingReminderNotification) {
                    Alert(title: Text("Reminder Set"), message: Text(""), dismissButton: .default(Text("Close")))
                }
                
                Text("Set Reminder")
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 25)
                
                Button(action: {
                    self.showingModal = false
                }, label: {
                    Text("Close")
                        .fontWeight(.semibold)
                })
                
            }
        }
    }
}

struct AppointmentConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentConfirmationView(showingModal: .constant(true))
            .environmentObject(Order())
    }
}

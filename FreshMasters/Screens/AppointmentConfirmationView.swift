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
    @State var alertItem: AlertItem?
    
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
                    
                    if(checkReminderAuthorizationStatus()){
                        //MARK: - todo check if successful
                        addReminder(title: "FreshMasters detailing appointment today", note: "\(order.vehicle.year) \(order.vehicle.make) \(order.vehicle.model), \(order.vehicle.serviceType)",
                                    date: order.customer.appointmentDate)
                        
                        alertItem = ReminderAlerts.reminderSet
                    }else{
                        alertItem = ReminderAlerts.reminderNotAuthorized
                    }
                    
                }, label: {
                    VStack{
                        HStack{
                            Image(systemName: "deskclock")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("Set Reminder")
                        }
                        
                    }
                    .foregroundColor(.white)
                })
                .frame(width: 200, height: 50)
                .background(Color.green)
                .cornerRadius(8)
                .alert(item: $alertItem){ alertItem in
                    switch alertItem.title{
                        case Text("Reminder Set"):
                            return Alert(title: alertItem.title, message: alertItem.message,
                                     dismissButton: alertItem.dismissButton)
                        case Text("Permissions Required"):
                            let openSettingsButton = Alert.Button.default(Text("Open Settings")) {
                                if let settingsUrl = URL(string: UIApplication.openSettingsURLString){
                                   UIApplication.shared.open(settingsUrl)
                                }
                            }
                            
                            return Alert(title: alertItem.title, message: alertItem.message,
                              primaryButton: openSettingsButton,
                              secondaryButton: .destructive(Text("Close"))
                            )
                    default:
                        print("wrong title switch")
                        return Alert(title: alertItem.title, message: alertItem.message,
                                 dismissButton: alertItem.dismissButton)
                    }
                }
                
                Button(action: {
                    self.showingModal = false
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: MainView().environmentObject(Order()))
                        window.makeKeyAndVisible()
                    }
                }, label: {
                    Text("Done")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                })
                .frame(width: 200, height: 50)
                .background(Color.blue)
                .cornerRadius(8)
                
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

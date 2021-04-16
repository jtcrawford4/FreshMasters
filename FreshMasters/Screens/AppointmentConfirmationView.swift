//
//  AppointmentConfirmationView.swift
//  FreshMasters
//
//  Created by John Crawford on 4/1/21.
//

import SwiftUI
import SafariServices

struct AppointmentConfirmationView: View {
    
    @EnvironmentObject var order: Order
    @State var alertItem: AlertItem?
    @State var safariModalPresented = false
    
    var body: some View {
        var safariURL = ""
        ZStack{

            Image("backgroundAppointmentImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brandPrimary, Color.gray]), startPoint: .top, endPoint: .bottomTrailing))
                .ignoresSafeArea()
                .opacity(0.4)
        
            VStack{
                
                ZStack{
                    
                    Rectangle()
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.4)
                    
                    VStack{
                        Text("Appointment Confirmed")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.bottom, 80)
                       
                        AppointmentCalendar(date: order.customer.appointmentDate)
                            .padding(.bottom, 20)
                        
                        Text("Please reach out if any questions or comments arise regarding your appointment.")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                            .multilineTextAlignment(.center)
                        
                        HStack{
                            
                            Button(action: {
                                safariURL = "http://freshmastersdetail.com/contact/"
                                safariModalPresented.toggle()
                            }, label: {
                                Text("Contact")
                                    .foregroundColor(.white)
                            })
                            .frame(width: 100, height: 40)
                            .background(Color.black)
                            .cornerRadius(4.0)
                            
                            Spacer()
                            
                            Button(action: {
                                safariURL = "http://freshmastersdetail.com/gallery/"
                                safariModalPresented.toggle()
                            }, label: {
                                Text("Gallery")
                                    .foregroundColor(.white)
                            })
                            .frame(width: 100, height: 40)
                            .background(Color.black)
                            .cornerRadius(4.0)
                        }
                        .frame(width: 200, height: 40)
                        .padding(.bottom, 20)
                        
                        
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
            .navigationBarHidden(true)
            .sheet(isPresented: $safariModalPresented) {
                SafariView(url:URL(string: safariURL)!)
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
}

struct AppointmentConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentConfirmationView()
            .environmentObject(Order())
    }
}

//
//  AppointmentView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AppointmentView: View {
    
    @EnvironmentObject var order: Order
    @State var showingConfirmation = false
    @State var alertItem: AlertItem?
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                Form{
                    Section(header: Text("Contact Info")){
                        TextField("First Name", text: $order.customer.firstName)
                        TextField("Last Name", text: $order.customer.lastName)
                        TextField("Phone", text: $order.customer.phone)
                            .keyboardType(.phonePad)
                        TextField("Email", text: $order.customer.email)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        DatePicker("Appointment Date",
                                   selection: $order.customer.appointmentDate,
                                   in: tomorrow...,
                                   displayedComponents: .date)
                    }
                    Section(header: Text("Preferred Contact Method(s)")){
                        Toggle("Email", isOn: $order.customer.contactByEmail)
                        Toggle("Phone", isOn: $order.customer.contactByPhone)
                        Toggle("Text", isOn: $order.customer.contactByText)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                    
                }
                .background(Color.background)
                
                Button{
                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                    impactMed.impactOccurred()
                    sendEmail(customer: order.customer, vehicle: order.vehicle){ result in
                        switch result {
                        case .success(true):
                            showingConfirmation.toggle()
                        case .failure(let error):
                            switch error {
                            case .emailFailure:
                                alertItem = AlertContext.emailFailure
                            }
                        case .success(false):
                            print("unknown error?")
                        }
                    }
                    
                } label: {
                    HStack{
                        Text("Submit")
                            .font(.body)
                            .fontWeight(.semibold)
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.brandPrimary)
                            .shadow(color: .backgroundHighlight, radius: 2, x: -3, y: -3)
                            .shadow(color: .backgroundShadow, radius: 2, x: 3, y: 3)
                    }
                    
                }
                .frame(width: 200, height: 50)
                .buttonStyle(SquareButtonStyle())
                .padding(40)
                .sheet(isPresented: $showingConfirmation) {
                    AppointmentConfirmationView(showingModal: $showingConfirmation)
                }
                .alert(item: $alertItem){ alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                }
                
            }
            .navigationTitle("Appointment")

        }
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
            .environmentObject(Order())
    }
}

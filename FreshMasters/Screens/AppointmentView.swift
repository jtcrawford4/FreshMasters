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
    @State var isSendingAppointment = false
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @State var phone = ""
    @State var email = ""
        
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
                        TextField("Phone", text: $phone)
                            .keyboardType(.phonePad)
                        TextField("Email", text: $email)
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
                            .disabled(email.isEmpty)
                        Toggle("Phone", isOn: $order.customer.contactByPhone)
                            .disabled(phone.isEmpty)
                        Toggle("Text", isOn: $order.customer.contactByText)
                            .disabled(phone.isEmpty)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                    
                    Section(){
                        Button(action: {
                            order.customer.phone = phone
                            order.customer.email = email
                            let validation = order.customer.isValidForm()
                            switch validation{
                                case .valid:
                                    isSendingAppointment = true
                                    let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                    impactMed.impactOccurred()
                                    sendEmail(customer: order.customer, vehicle: order.vehicle){ result in
                                        switch result {
                                            case .success(true):
                                                showingConfirmation.toggle()
                                            case .success(false):
                                                print("unknown error?")
                                            case .failure(let error):
                                                switch error {
                                                    case .emailFailure:
                                                        alertItem = AlertContext.emailFailure
                                                }
                                        }
                                        isSendingAppointment = false
                                    }
                                case .invalidForm:
                                    alertItem = AlertContext.invalidAppointmentForm
                                case .missingPhoneEmail:
                                    alertItem = AlertContext.missingPhoneEmail
                                case .invalidEmail:
                                    alertItem = AlertContext.invalidEmail
                                case .invalidPhone:
                                    alertItem = AlertContext.invalidPhone
                            }
                        }, label: {
                            HStack{
                                Text("Submit")
                                    .font(.body)
                                    .fontWeight(.semibold)
                            }
                        })
                        .buttonStyle(PlainButtonStyle())
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                        .sheet(isPresented: $showingConfirmation) {
                            AppointmentConfirmationView(showingModal: $showingConfirmation)
                        }
                        .alert(item: $alertItem){ alertItem in
                            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                        }
                    }
                    .listRowBackground(Color.blue)
                    
                }
                .background(Color.background)
                
            }
            .navigationTitle("Appointment")
            .blur(radius: isSendingAppointment ? 10 : 0)
            .disabled(isSendingAppointment)
            
            if(isSendingAppointment){
                ActivityIndicator(shouldAnimate: $isSendingAppointment)
            }
        }
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
            .environmentObject(Order())
    }
}

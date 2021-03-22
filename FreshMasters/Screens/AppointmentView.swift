//
//  AppointmentView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AppointmentView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
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
                        DatePicker("Appointment Date", selection: $order.customer.appointmentDate, displayedComponents: .date)
                    }
                    Section(header: Text("Preferred Contact Method(s)")){
                        Toggle("Email", isOn: $order.customer.contactByEmail)
                        Toggle("Phone", isOn: $order.customer.contactByPhone)
                        Toggle("Text", isOn: $order.customer.contactByText)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                    
                    //MARK: - add reminder
                    
                }
                .background(Color.offWhite)
                
                Button{
                    print("appointment sent")
                } label: {
                    HStack{
                        Text("Submit")
                            .font(.body)
                            .fontWeight(.semibold)
                        Image(systemName: "paperplane.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.brandPrimary)
                            .shadow(color: .white, radius: 2, x: -3, y: -3)
                            .shadow(color: .gray, radius: 2, x: 3, y: 3)
                    }
                    
                }
                .frame(width: 200, height: 50)
                .buttonStyle(SquareButtonStyle())
                .padding(40)
                
            }
            .navigationTitle("Appointment")

        }
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}

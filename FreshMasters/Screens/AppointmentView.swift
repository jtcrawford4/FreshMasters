//
//  AppointmentView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AppointmentView: View {
    
    @State var fname = ""
    @State var lname = ""
    @State var email = ""
    @State var phone = ""
    @State var appointmentDate = Date()
    @State var canContactByEmail = false
    @State var canContactByPhoneText = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            NavigationView{
                    Form{
                        Section(header: Text("Contact Info")){
                            TextField("First Name", text: $fname)
                            TextField("Last Name", text: $lname)
                            TextField("Phone", text: $phone)
                                .keyboardType(.phonePad)
                            TextField("Email", text: $email)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                            DatePicker("Appointment Date", selection: $appointmentDate, displayedComponents: .date)
    //                        Button{
    //                           viewModel.saveChanges()
    //                        } label: {
    //                            Text("Save Changes")
    //                        }
                        }
                        Section(header: Text("Contact Type")){
                            Toggle("Contact by email?", isOn: $canContactByEmail)
                            Toggle("Contact by phone / text?", isOn: $canContactByPhoneText)
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
                        
                        Section(){
                            Button(action: {
                                print("appointment sent")
                            }, label: {
                                Text("Submit")
                                    .foregroundColor(.black)
//                                    .buttonStyle(PlainButtonStyle())
//                                    .background(Color.brand)
//                                    .frame(width: 250, height: 50)
//                                    .buttonStyle(SquareButtonStyle())
                            })
//                            .buttonStyle(PlainButtonStyle())
                        }
//                        .background(Color.brandPrimary)
                        
                        
                    }
                    .navigationTitle("Appointment")
                
                
                
                
            }
//            .offset(y: -60)
//            .onAppear{
//                viewModel.retrieveUser()
//            }
        }
    }
}

struct AppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        AppointmentView()
    }
}

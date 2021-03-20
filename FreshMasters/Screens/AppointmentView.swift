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
    @State var contactByEmail = false
    @State var contactByPhone = false
    @State var contactByText = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
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
                    }
                    Section(header: Text("Preferred Contact Method(s)")){
                        Toggle("Email", isOn: $contactByEmail)
                        Toggle("Phone", isOn: $contactByPhone)
                        Toggle("Text", isOn: $contactByText)
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

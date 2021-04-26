//
//  VehicleTypeDetailView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/24/21.
//

import SwiftUI

struct VehicleTypeDetailView: View {
    
    @EnvironmentObject var order: Order
    @State var year = ""
    @State var make = ""
    @State var model = ""
    @State var alertItem: AlertItem?
    @State var isValidated = false
    
    var body: some View {
        
        let vehicle = order.vehicle
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
                        
            VStack{
                
                TitleText(text: "Tell us more about your \(vehicle.vehicleType.lowercased())")
                
                VStack{
                    TextField("Year", text: $year)
                        .onChange(of: year, perform: { value in
                        isValidated = false
                        self.year = year.limit(characterLimit: 4, string: value)
                    })
                    .keyboardType(.numberPad)

                    TextField("Make", text: $make)
                        .onChange(of: make, perform: { value in
                        isValidated = false
                        self.make = make.limit(characterLimit: 20, string: value)
                    })
                    
                    TextField("Model", text: $model)
                        .onChange(of: model, perform: { value in
                        isValidated = false
                        self.model = model.limit(characterLimit: 20, string: value)
                    })

                }
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                
                NavigationLink("Skip", destination: ServiceTypeView())
                    .padding(.top, 40)
                    .foregroundColor(.blue)
                    .simultaneousGesture(TapGesture().onEnded{
                        vehicle.year = ""
                        vehicle.make = ""
                        vehicle.model = ""
                        vehicle.hasAgeSurcharge = false
                    })
                
                Button(action: {
                    vehicle.year = year
                    vehicle.make = make
                    vehicle.model = model
                    let validated = vehicle.isValidYearMakeModel()
                    switch validated {
                        case .valid:
                            isValidated = true
                        case .invalidYear:
                            alertItem = AlertContext.invalidYear
                        case .invalidMake:
                            alertItem = AlertContext.invalidMake
                        case .invalidModel:
                            alertItem = AlertContext.invalidModel
                    }                    
                }, label: {
                    Text("Validate")
                })
                .buttonStyle(SquareButtonStyle())
                .opacity(isValidated ? 0 : 1)
                .frame(width: 160, height: 80)
                .padding(.top, 40)
                                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", isEnabled: true, content: {ServiceTypeView()})
                    .frame(width: 160, height: 80)
                    .opacity(isValidated ? 1 : 0)
                    .simultaneousGesture(TapGesture().onEnded{
                        vehicle.hasAgeSurcharge = vehicle.prices.vehicleHasAgeSurcharge(year: vehicle.year)
                    })

            }
            .padding(.bottom, 60)
            .alert(item: $alertItem){ alertItem in
                Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
            }
            .onAppear(perform: {
                isValidated = false
            })

        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
}

struct VehicleTypeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleTypeDetailView()
            .environmentObject(Order())
    }
}

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
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
                        
            VStack{
                
                TitleText(text: "Tell us more about your \(order.vehicle.vehicleType.lowercased())")
                
                VStack{
                    TextField("Year", text: $year)
                        .onChange(of: year, perform: { value in
                        isValidated = false
                        self.year = year.StringLimit(characterLimit: 4, string: year)
                    })
                    .keyboardType(.numberPad)

                    TextField("Make", text: $make)
                        .onChange(of: make, perform: { value in
                        isValidated = false
                        self.make = make.StringLimit(characterLimit: 20, string: make)
                    })
                    
                    TextField("Model", text: $model)
                        .onChange(of: model, perform: { value in
                        isValidated = false
                        self.model = model.StringLimit(characterLimit: 20, string: model)
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
                        order.vehicle.year = ""
                        order.vehicle.make = ""
                        order.vehicle.model = ""
                    })
                
                Button(action: {
                    order.vehicle.year = year
                    order.vehicle.make = make
                    order.vehicle.model = model
                    let validated = order.vehicle.isValidYearMakeModel()
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
                        order.vehicle.hasAgeSurcharge = order.vehicle.prices.vehicleHasAgeSurcharge(year: order.vehicle.year)
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
    }
}

struct VehicleTypeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleTypeDetailView()
            .environmentObject(Order())
    }
}

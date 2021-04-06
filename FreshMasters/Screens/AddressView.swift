//
//  AddressView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct AddressView: View {
    
    @EnvironmentObject var order: Order
    @State var isValidated = false
    @State var street = ""
    @State var city = ""
    @State var state = ""
    @State var zip = ""
    @State var alertItem: AlertItem?
    @State var alertOutOfServiceArea = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                TitleText(text: "Where would you like the service completed?")
                
                VStack{
                    TextField("Street Address", text: $street)
                        .onChange(of: street, perform: { value in
                            isValidated = false
                        })
                    TextField("City", text: $city)
                        .onChange(of: city, perform: { value in
                            isValidated = false
                        })
                    TextField("State", text: $state)
                        .onChange(of: state, perform: { value in
                            isValidated = false
                        })
                    TextField("Zip", text: $zip)
                        .onChange(of: zip, perform: { value in
                            isValidated = false
                        })
                        .keyboardType(.numberPad)
                }
                .padding(20)
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                
                Button(action: {
                    order.customer.address.streetAddress = street
                    order.customer.address.city = city
                    order.customer.address.state = state
                    order.customer.address.zip = zip
                    order.customer.address.getDistanceToCustomer(){ result in
                        switch result {
                        case .success(let miles):
                            isValidated = true
                            order.vehicle.prices.milesToCustomer = miles
                            order.vehicle.prices.calculateMileageCost(milesToCustomer: miles)
                        case .failure(let error):
                            switch error {
                            case .invalidAddress:
                                alertItem = AlertContext.invalidAddress
                            case .invalidCityZip:
                                alertItem = AlertContext.invalidCityZip
                            case .invalidStreetCityZip:
                                alertItem = AlertContext.invalidStreetCityZip
                            case .invalidCoordinate:
                                alertItem = AlertContext.invalidCoordinate
                            case .outsideServiceArea:
                                alertItem = AlertContext.outsideServiceArea
                            case .unknown:
                                alertItem = AlertContext.unknown
                            }
                        }
                    }
                }, label: {
                    Text("Validate")
                })
                .buttonStyle(SquareButtonStyle())
                .opacity(isValidated ? 0 : 1)
                
                                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Quote", isEnabled: true, content: {QuoteView()})
                    .frame(width: 200, height: 80)
                    .padding(.top, 40)
                    .opacity(isValidated ? 1 : 0)
                }
                .offset(y: -60)
                .alert(item: $alertItem){ alertItem in
                    Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)

            }
            .onAppear(perform: {
                isValidated = false
            })
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
            .environmentObject(Order())
    }
}

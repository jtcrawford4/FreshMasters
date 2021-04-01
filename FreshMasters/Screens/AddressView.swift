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
    @State var alertItem: AlertItem?
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                TitleText(text: "Where would you like the service completed?")
                
                VStack{
                    TextField("Street Address", text: $order.customer.address.streetAddress)
                    TextField("City", text: $order.customer.address.city)
                    TextField("State", text: $order.customer.address.state)
                    TextField("Zip", text: $order.customer.address.zip)
                        .keyboardType(.numberPad)
                }
                .padding(20)
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                
                Button(action: {
                    order.customer.address.getDistanceToCustomer(){ result in
                        switch result {
                        case .success(let miles):
                            print("async return: \(miles)")
                            isValidated = true
                            //MARK: - redundant eh?
                            order.vehicle.prices.milesToCustomer = miles
                            order.vehicle.prices.calculateMileageCost(milesToCustomer: miles)
                        case .failure(let error):
                            switch error {
                            case .invalidAddress:
                                print("invalid address")
                                alertItem = AlertContext.invalidAddress
                            case .invalidCityZip:
                                print("Invalid city/zip combo")
                            case .invalidStreetCityZip:
                                print("Invalid street/city/zip combo")
                            case .invalidCoordinate:
                                print("invalid coordinate")
                                alertItem = AlertContext.invalidCoordinate
                            case .unknown:
                                print("Unknown error")
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

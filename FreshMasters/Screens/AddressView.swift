//
//  AddressView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct AddressView: View {
    
    @EnvironmentObject var order: Order
    @State var city = ""
    @State var zip = ""
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                TitleText(text: "Where would you like the service completed?")
                
                VStack{
                    TextField("Street Address", text: $order.customer.address.streetAddress)
                        
                    TextField("City", text: $city)
                    TextField("Zip", text: $zip)
                }
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                
                //MARK: - disable until address filled out. error handling
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Validate", isEnabled: (!city.isEmpty && !zip.isEmpty), content: {ValidationView()})
                    .frame(width: 200, height: 80)
                    .padding(.top, 40)
                    .disabled(city.isEmpty || zip.isEmpty)
                    .simultaneousGesture(TapGesture().onEnded{
                        if (!city.isEmpty && !zip.isEmpty){
                            order.customer.address.city = city
                            order.customer.address.zip = zip
                            order.customer.address.calcDistanceToCustomer()
                        }
                    })
            }
            .offset(y: -60)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView()
            .environmentObject(Order())
    }
}

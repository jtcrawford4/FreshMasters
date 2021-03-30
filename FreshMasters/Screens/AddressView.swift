//
//  AddressView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct AddressView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                TitleText(text: "Where would you like the service completed?")
                
                VStack{
                    TextField("Street Address", text: $order.customer.address.streetAddress)
                    TextField("City", text: $order.customer.address.city)
                    TextField("Zip", text: $order.customer.address.zip)
                }
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                
                //MARK: - disable until address filled out. error handling
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Validate", isEnabled: true, content: {ValidationView()})
                    .frame(width: 200, height: 80)
                    .padding(.top, 40)
                    .simultaneousGesture(TapGesture().onEnded{
                        order.customer.address.calcDistanceToCustomer()
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

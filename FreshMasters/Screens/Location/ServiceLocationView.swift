//
//  ServiceLocationView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct ServiceLocationView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                TitleText(text: "Where would you like the service completed?")
                
                HStack(spacing: 20){
                    NavLinkButtonVStack(image: Image(systemName: "mappin"), buttonText: "You Come To Us", isEnabled: true, content: {QuoteView()})
                        .frame(width: 150, height: 180)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.mobileService = false
                        })
                    
                    NavLinkButtonVStack(image: Image(systemName: "house.fill"), buttonText: "We Come To You", isEnabled: true, content: {AddressView()})
                        .frame(width: 150, height: 180)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.mobileService = true
                        })
                }
            }
            .offset(y: -60)
        }
    }
}

struct ServiceLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceLocationView()
            .environmentObject(Order())
    }
}

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
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Text("Where would you like the service completed?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 40)
                
                HStack(spacing: 20){
                    NavLinkButtonVStack(image: Image(systemName: "mappin"), buttonText: "You Come To Us", isEnabled: true, content: {QuoteView()})
                        .frame(width: 150, height: 180)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.customer.mobileService = false
                        })
                    
                    //MARK: - address screen
                    NavLinkButtonVStack(image: Image(systemName: "house.fill"), buttonText: "We Come To You", isEnabled: true, content: {QuoteView()})
                        .frame(width: 150, height: 180)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.customer.mobileService = true
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

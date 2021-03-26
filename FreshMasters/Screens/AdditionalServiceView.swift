//
//  AdditionalServiceView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AdditionalServiceView: View {
    
    @EnvironmentObject var order: Order
    @State private var polishIsToggled = false
    @State private var headlightIsToggled = false
    @State private var engineIsToggled = false
    @State private var glazeIsToggled = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                TitleText(text: "Any additional services needed?")
                         
                if order.vehicle.serviceType != Vehicle.serviceTypes.interior.rawValue{
                    HStack(spacing: 10){
                        ToggleButton(toggleState: $polishIsToggled, imageToggled: Image("icons8-sparkling-diamond-50-red"), imageNotToggled: Image("icons8-sparkling-diamond-50"), buttonText: "Paint Polish")
                            

                        ToggleButton(toggleState: $glazeIsToggled, imageToggled: Image("icons8-wet-50-red"), imageNotToggled: Image("icons8-wet-50"), buttonText: "Paint Glaze")
                    }
                }

                HStack(spacing: 10){
                    ToggleButton(toggleState: $engineIsToggled, imageToggled: Image("icons8-engine-50-red"), imageNotToggled: Image("icons8-engine-50"), buttonText: "Engine Bay \nDetail")

                    ToggleButton(toggleState: $headlightIsToggled, imageToggled: Image("icons8-headlight-50-red"), imageNotToggled: Image("icons8-headlight-50"), buttonText: "Headlight \nRestoration")
                }
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", isEnabled: true, content: {ServiceLocationView()})
                    .frame(width: 160, height: 80)
                    .padding(.top, 40)
                    .simultaneousGesture(TapGesture().onEnded{
                        order.vehicle.polish = polishIsToggled
                        order.vehicle.glaze = glazeIsToggled
                        order.vehicle.engine = engineIsToggled
                        order.vehicle.headlightRestore = headlightIsToggled
                    })
                
                Spacer()
                
            }
            .offset(y: -40)
            
        }
    }
}

struct AdditionalServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalServiceView()
            .environmentObject(Order())
    }
}

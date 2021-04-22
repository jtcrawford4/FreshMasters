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
        
        let vehicle = order.vehicle
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                TitleText(text: "Any additional services needed?")
                         
                if vehicle.serviceType != Vehicle.serviceTypes.interior.rawValue{
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
                        vehicle.polish = polishIsToggled
                        vehicle.glaze = glazeIsToggled
                        vehicle.engine = engineIsToggled
                        vehicle.headlightRestore = headlightIsToggled
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

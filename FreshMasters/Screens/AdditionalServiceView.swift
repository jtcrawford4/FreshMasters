//
//  AdditionalServiceView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AdditionalServiceView: View {
    
    @EnvironmentObject var order: Order
    @State var polishIsToggled = false
    @State var headlightIsToggled = false
    @State var engineIsToggled = false
    @State var glazeIsToggled = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Any additional services needed?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                                
                
                HStack(spacing: 10){

                    ToggleButton(toggleState: $polishIsToggled, imageToggled: Image("icons8-sparkling-diamond-50-red"), imageNotToggled: Image("icons8-sparkling-diamond-50"), buttonText: "Paint Polish")
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.polish = polishIsToggled
                        })

                    ToggleButton(toggleState: $glazeIsToggled, imageToggled: Image("icons8-wet-50-red"), imageNotToggled: Image("icons8-wet-50"), buttonText: "Show Glaze")
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.glaze = glazeIsToggled
                        })
                    
                }

                HStack(spacing: 10){

                    ToggleButton(toggleState: $engineIsToggled, imageToggled: Image("icons8-engine-50-red"), imageNotToggled: Image("icons8-engine-50"), buttonText: "Engine Bay \nDetail")
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.engine = engineIsToggled
                        })

                    ToggleButton(toggleState: $headlightIsToggled, imageToggled: Image("icons8-headlight-50-red"), imageNotToggled: Image("icons8-headlight-50"), buttonText: "Headlight \nRestoration")
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.headlightRestore = headlightIsToggled
                        })
                    
                }
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Quote", isEnabled: true, content: {QuoteView()})
                    .frame(width: 200, height: 80)
                    .padding(.top, 40)
                
                Spacer()
                
            }
            .offset(y: -40)
            
        }
    }
}

struct AdditionalServiceView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalServiceView()
    }
}

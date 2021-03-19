//
//  AdditionalServiceView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct AdditionalServiceView: View {
    
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
//                    Spacer()
                    ToggleButton(toggleState: $polishIsToggled, imageToggled: Image("icons8-sparkling-diamond-50-red"), imageNotToggled: Image("icons8-sparkling-diamond-50"), buttonText: "Paint \nPolish")
//                        .frame(width: 160, height: 170)
//                        .padding()
//                    Spacer()
                    ToggleButton(toggleState: $headlightIsToggled, imageToggled: Image("icons8-headlight-50-red"), imageNotToggled: Image("icons8-headlight-50"), buttonText: "Headlight \nRestoration")
//                        .frame(width: 150, height: 170)
//                    Spacer()
                }
//                .padding(-50)
                HStack(spacing: 10){
//                    Spacer()
                    ToggleButton(toggleState: $engineIsToggled, imageToggled: Image("icons8-engine-50-red"), imageNotToggled: Image("icons8-engine-50"), buttonText: "Engine Bay \nDetail")
//                        .frame(width: 150, height: 170)

                    ToggleButton(toggleState: $glazeIsToggled, imageToggled: Image("icons8-wet-50-red"), imageNotToggled: Image("icons8-wet-50"), buttonText: "Show Car \nGlaze")
//                        .frame(width: 150, height: 170)
//                    Spacer()
                }
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", content: {ValidationView()})
                    .frame(width: 160, height: 80)
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

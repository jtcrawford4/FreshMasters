//
//  ServiceTypeView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/17/21.
//

import SwiftUI

struct ServiceTypeView: View {
    
    @EnvironmentObject var order: Order
    @State private var interiorIsToggled = false
    @State private var exteriorIsToggled = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("What detailing services are needed?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(spacing: 10){
                    ToggleButton(toggleState: $interiorIsToggled, imageToggled: Image("icons8-steering-wheel-50-red"), imageNotToggled: Image("icons8-steering-wheel-50"), buttonText: "Interior")
                        .buttonStyle(SquareButtonStyle())
                        
                
                    ToggleButton(toggleState: $exteriorIsToggled, imageToggled: Image("icons8-car-cleaning-50-red"), imageNotToggled: Image("icons8-car-cleaning-50"), buttonText: "Exterior")
                        .buttonStyle(SquareButtonStyle())

                }
                .padding()
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", isEnabled: (exteriorIsToggled || interiorIsToggled), content: {AdditionalServiceView()})
                    .frame(width: 160, height: 80)
                    .padding(.top, 40)
                    .simultaneousGesture(TapGesture().onEnded{
                        var temp = ""
                        if (exteriorIsToggled && interiorIsToggled) {
                            temp = Vehicle.serviceTypes.full.rawValue
                        }
                        else if (exteriorIsToggled){
                            temp = Vehicle.serviceTypes.exterior.rawValue
                        }
                        else if (interiorIsToggled){
                            temp = Vehicle.serviceTypes.interior.rawValue
                        }
                        order.vehicle.serviceType = temp
                    })
                    .disabled(!(exteriorIsToggled || interiorIsToggled))
                    
                Spacer()
            }
            .offset(y: -60)
        }
    }
}

struct ServiceTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceTypeView()
            .environmentObject(Order())
    }
}

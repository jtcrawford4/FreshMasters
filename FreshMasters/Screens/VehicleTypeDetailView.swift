//
//  VehicleTypeDetailView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/24/21.
//

import SwiftUI

struct VehicleTypeDetailView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
                        
            VStack{
                
                TitleText(text: "Tell us more about your \(order.vehicle.vehicleType)")
                
                VStack{
                    TextField("Year", text: $order.vehicle.year)
                        .keyboardType(.numberPad)
                    TextField("Make", text: $order.vehicle.make)
                    TextField("Model", text: $order.vehicle.model)
                }
                .padding()
                .font(.title)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Next", isEnabled: true, content: {ServiceTypeView()})
                    .frame(width: 160, height: 80)
                    .padding(.top, 40)
                    
            }
            .padding(.bottom, 60)
//            .position(y: 10)
        }
    }
}

struct VehicleTypeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleTypeDetailView()
            .environmentObject(Order())
    }
}

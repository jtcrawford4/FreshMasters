//
//  SecondView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/17/21.
//

import SwiftUI

struct VehicleTypeView: View {
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()

            VStack{
                Spacer()
                Text("What type of vehicle will be serviced?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(spacing: 10){
                    NavLinkButton(image: Image("icons8-car-50"), buttonText: "Car", content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                    NavLinkButton(image: Image("icons8-pickup-30"), buttonText: "Truck", content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                }
                .padding()
                
                HStack(spacing: 10){
                    NavLinkButton(image: Image("icons8-vanpool-30"), buttonText: "Van", content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                    
                    NavLinkButton(image: Image("icons8-jeep-50-2"), buttonText: "SUV", content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                }
                Spacer()
            }
            .offset(y: -60)
            
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleTypeView()
    }
}

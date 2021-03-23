//
//  SecondView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/17/21.
//

import SwiftUI

struct VehicleTypeView: View {
    
    @EnvironmentObject var order: Order
    
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
                    NavigationLinkButton(image: Image("icons8-car-50"), buttonText: "Car", isEnabled: true, content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.vehicleType = Vehicle.vehicleType.car.rawValue
                            order.prices = CarPrices()
                        })
                    NavigationLinkButton(image: Image("icons8-pickup-30"), buttonText: "Truck", isEnabled: true, content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.vehicleType = Vehicle.vehicleType.truck.rawValue
                            order.prices = TruckPrices()
                        })
                }
                .padding()
                
                HStack(spacing: 10){
                    NavigationLinkButton(image: Image("icons8-vanpool-30"), buttonText: "Van", isEnabled: true, content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.vehicleType = Vehicle.vehicleType.van.rawValue
                            order.prices = VanPrices()
                        })
                    
                    NavigationLinkButton(image: Image("icons8-jeep-50-2"), buttonText: "SUV", isEnabled: true, content: {ServiceTypeView()})
                        .frame(width: 160, height: 80)
                        .simultaneousGesture(TapGesture().onEnded{
                            order.vehicle.vehicleType = Vehicle.vehicleType.suv.rawValue
                            order.prices = SuvPrices()
                        })
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

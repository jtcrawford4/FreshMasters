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
        
        let vehicle = order.vehicle
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()

            VStack{
                Spacer()
                TitleText(text: "What type of vehicle will be serviced?")
                
                HStack(spacing: 15){
                    NavLinkButtonVStack(image: Image("icons8-car-50"), buttonText: "Car", isEnabled: true, content: {VehicleTypeDetailView()})
                        .frame(width: 120, height: 120)
                        .simultaneousGesture(TapGesture().onEnded{
                            vehicle.vehicleType = Vehicle.vehicleTypes.car.rawValue
                            vehicle.prices = CarPrices()
                        })
                    NavLinkButtonVStack(image: Image("icons8-pickup-30"), buttonText: "Truck", isEnabled: true, content: {VehicleTypeDetailView()})
                        .frame(width: 120, height: 120)
                        .simultaneousGesture(TapGesture().onEnded{
                            vehicle.vehicleType = Vehicle.vehicleTypes.truck.rawValue
                            vehicle.prices = TruckPrices()
                        })
                }
                .padding(.bottom, 30)
                
                HStack(spacing: 15){
                    NavLinkButtonVStack(image: Image("icons8-vanpool-30"), buttonText: "Van", isEnabled: true, content: {VehicleTypeDetailView()})
                        .frame(width: 120, height: 120)
                        .simultaneousGesture(TapGesture().onEnded{
                            vehicle.vehicleType = Vehicle.vehicleTypes.van.rawValue
                            vehicle.prices = VanPrices()
                        })
                    
                    NavLinkButtonVStack(image: Image("icons8-jeep-50-2"), buttonText: "SUV", isEnabled: true, content: {VehicleTypeDetailView()})
                        .frame(width: 120, height: 120)
                        .simultaneousGesture(TapGesture().onEnded{
                            vehicle.vehicleType = Vehicle.vehicleTypes.suv.rawValue
                            vehicle.prices = SuvPrices()
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
            .preferredColorScheme(.dark)
    }
}

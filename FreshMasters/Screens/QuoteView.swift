//
//  QuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteView: View {
    
    @EnvironmentObject var order: Order
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.offWhite)
    }
    
    var body: some View {

            ZStack{
                
                Rectangle()
                    .fill(Color.offWhite)
                    .ignoresSafeArea()
                
                List{
                    QuoteCell(title: "Vehicle Type", value: order.vehicle.vehicleType)
                    QuoteCell(title: "Service Type", value: order.vehicle.serviceType)
                    if (order.vehicle.polish){
                        QuoteCell(title: "Paint Polish", value: order.prices.polish)
                    }
                    if (order.vehicle.glaze){
                        QuoteCell(title: "Paint Glaze", value: order.prices.glaze)
                    }
                    if (order.vehicle.engine){
                        QuoteCell(title: "Engine Bay Detail", value: order.prices.engine)
                    }
                    if (order.vehicle.headlightRestore){
                        QuoteCell(title: "Headlight Restoration", value: order.prices.headlightRestoration)
                    }
//                    , specifier: "%.2f"
//                    QuoteCell(title: "Total", value: "\(order.price.getTotalPrice())")
                     
//                    QuoteCell(title: "Service Type", value: order.vehicle.serviceType)
//                    QuoteCell(title: "Test", value: 100)
//                    QuoteCell(title: "Test", value: 100)
//                    QuoteCell(title: "Test", value: 100)
//                    QuoteCell(title: "Test", value: 100)
//                    QuoteCell(title: "Test", value: 100)
                }
                .padding(.top)
                .navigationTitle("Itemized Quote")
                
                VStack{

                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                        .frame(width: 280, height: 80)
                        .padding(.top, 40)
                    
                }
            }
            .background(Color.clear)
            .onAppear(perform: {
                print("quote up")
            })

    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}

//
//  ItemizedQuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/23/21.
//

import SwiftUI

struct ItemizedQuoteView: View {
    
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
                        QuoteCell(title: "Paint Polish", value: order.vehicle.prices.polish)
                    }
                    if (order.vehicle.glaze){
                        QuoteCell(title: "Paint Glaze", value: order.vehicle.prices.glaze)
                    }
                    if (order.vehicle.engine){
                        QuoteCell(title: "Engine Bay Detail", value: order.vehicle.prices.engine)
                    }
                    if (order.vehicle.headlightRestore){
                        QuoteCell(title: "Headlight Restoration", value: order.vehicle.prices.headlightRestoration)
                    }

//                    QuoteCell(title: "Total", value: "\(order.price.getTotalPrice())")

                }
                .padding(.top)
                .navigationTitle("Itemized Quote")
                
                //MARK: - back button
//                VStack{
//
//                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
//                        .frame(width: 280, height: 80)
//                        .padding(.top, 40)
//
//                }
            }
            .background(Color.clear)
            .onAppear(perform: {
                print("quote up")
            })

    }
}

struct ItemizedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ItemizedQuoteView()
    }
}

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
                
                VStack{
                    
                    VStack{
//                        LinearGradient(.red, .pink)
//                            .mask(Image("icons8-pickup-90")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width:100, height: 125)
//                            )
//                            .frame(width:100, height: 125)
//                            .shadow(color: .white, radius: 2, x: -3, y: -3)
//                            .shadow(color: .gray, radius: 2, x: 3, y: 3)
                        
                        Text(order.vehicle.getYearMakeModel())
                            .font(.body)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.init(top: 20, leading: 0, bottom: 20, trailing: 0))
                 
                    List{
                        //ugliest thing in the world
                        QuoteCell(title: order.vehicle.serviceType,
                                  value: order.vehicle.getServiceTypePrice(
                                    service: Vehicle.serviceTypes(rawValue: order.vehicle.serviceType)!))
                        
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
                        
                        QuoteCell(title: "Total", value: order.vehicle.getTotalPrice())
                            .font(.title2)
                            .foregroundColor(.green)

                    }
                    .padding(.top)
                    .navigationTitle("Itemized Quote")
                }
                
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
            .environmentObject(Order())
    }
}

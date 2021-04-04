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
        UITableView.appearance().backgroundColor = UIColor(Color.background)
    }
    
    var body: some View {

            ZStack{
                
                Rectangle()
                    .fill(Color.background)
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
                        
                        if (order.vehicle.mobileService){
                            QuoteCell(title: "Mileage", value: order.vehicle.prices.mileage)
                        }
                        
                        //MARK: - add info button that clicks and gives explanation
                        if (order.vehicle.hasAgeSurcharge){
                            QuoteCell(title: "Vehicle Age Surcharge", value: order.vehicle.prices.yearSurcharge)
                        }
                        
                        QuoteCell(title: "Total", value: order.vehicle.getTotalPrice())
                            .font(.title2)
                            .foregroundColor(.green)

                    }
                    .padding(.top)
                    .navigationTitle("Itemized Quote")
                    
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                        .frame(width: 280, height: 80)
                        .padding(.top, 40)
                        .offset(y: -100)
                }
                
            }
            .background(Color.clear)
        
    }
}

struct ItemizedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        ItemizedQuoteView()
            .environmentObject(Order())
    }
}

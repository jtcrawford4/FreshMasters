//
//  ItemizedQuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/23/21.
//

import SwiftUI

struct ItemizedQuoteView: View {
    
    @EnvironmentObject var order: Order
    @State var infoPresented = false
    let ageSurchargeInfoText: String = "Vehicles older than 5 years, especially those that have never been professionally detailed, generally require more time and attention to complete. \n\nSurcharge can potentially be void after in-person vehicle inspection.\n\nSurcharge calculated as percentage of total service cost."
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.background)
    }
    
    var body: some View {

        let vehicle = order.vehicle
        let prices = vehicle.prices
        
            ZStack{
                
                Rectangle()
                    .fill(Color.background)
                    .ignoresSafeArea()
                
                VStack{
                    
                    VStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 60, height: 40)
                        
                        Text("Itemized Quote")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.bottom, 20)
                        
                        Text(vehicle.getYearMakeModel())
                            .font(.body)
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                 
                    List{
                        QuoteCell(title: vehicle.serviceType,
                                  value: vehicle.getServiceTypePrice(
                                    service: Vehicle.serviceTypes(rawValue: vehicle.serviceType)!))
                        
                        if (vehicle.polish){
                            QuoteCell(title: "Paint Polish", value: prices.polish)
                        }
                        if (vehicle.glaze){
                            QuoteCell(title: "Paint Glaze", value: prices.glaze)
                        }
                        if (vehicle.engine){
                            QuoteCell(title: "Engine Bay Detail", value: prices.engine)
                        }
                        if (vehicle.headlightRestore){
                            QuoteCell(title: "Headlight Restoration", value: prices.headlightRestoration)
                        }
                        
                        if (vehicle.mobileService){
                            QuoteCell(title: "Mobile Service", value: prices.mileageSurcharge)
                        }
                        
                        if (vehicle.hasAgeSurcharge){
                            HStack{
                                Text("Vehicle Age Surcharge")
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                                
                                Button(action: {
                                    infoPresented.toggle()
                                }, label: {
                                    Image(systemName: "info.circle")
                                })
                                .alert(isPresented: $infoPresented) {
                                    Alert(title: Text("Vehicle Age Surcharge"), message: Text(ageSurchargeInfoText), dismissButton: .default(Text("Close")))
                                }
                                
                                Spacer()
                                Text("$\(prices.yearSurcharge, specifier: "%.2f")")
                            }
                            .listRowBackground(Color.background)
                        }
                        
                        QuoteCell(title: "Total", value: vehicle.getTotalPrice())
                            .font(.title2)
                            .foregroundColor(.green)

                    }
                    .padding(.top)
                    
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

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
        let hasValidPromoCode = prices.hasValidPromoCode
//        let hasValidPromoCode = true
        
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
                    .padding(.init(top: 0, leading: 0, bottom: 10, trailing: 0))
                 
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
//                            QuoteCell(title: "Mobile Service", value: prices.mileageSurcharge)
                            
                            getMobileCell(hasValidPromoCode: hasValidPromoCode, prices: prices)
                        }
                        
                        if (vehicle.hasAgeSurcharge){
                            HStack{
                                Text("Vehicle Age Surcharge")
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                                    .strikethrough(hasValidPromoCode, color: Color.brandPrimary)
                                
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
                                    .strikethrough(hasValidPromoCode, color: Color.brandPrimary)
                            }
                            .listRowBackground(Color.background)
                            
                        }
                        
                        QuoteCell(title: "Total", value: vehicle.totalPrice)
                            .font(.title2)
                            .foregroundColor(.green)

                    }
                    .padding(.top, 5)
                    
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                        .frame(width: 280, height: 80)
                        .padding(.top, 40)
                        .offset(y: -50)
                }
                
            }
            .background(Color.clear)
        
    }
}

struct getMobileCell: View{
    var hasValidPromoCode: Bool
    var prices: Prices
    var body: some View{
        HStack{
            Text("Mobile Service")
                .fontWeight(.regular)
                .foregroundColor(.secondary)
                .strikethrough(hasValidPromoCode, color: Color.brandPrimary)
            
            Spacer()
            
            Text("$\(prices.mileageSurcharge, specifier: "%.2f")")
                .strikethrough(hasValidPromoCode, color: Color.brandPrimary)
        }
        .listRowBackground(Color.background)
    }
}

struct ItemizedQuoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ItemizedQuoteView()
                .environmentObject(Order().sampleOrder())
        }
    }
}

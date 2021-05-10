//
//  QuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteView: View {
    
    @EnvironmentObject var order: Order
    @State var promoModalShowing = false
    @State var totalPrice: Double = 0
    
    var body: some View{
        
        let vehicle = order.vehicle
        let hours = vehicle.hours
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
         
            VStack{
                
                Text("$ \(totalPrice, specifier: "%.2f")")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
//                    .padding(.bottom, 30)
                
                if(vehicle.prices.hasValidPromoCode){
                    VStack{
                        
                        Text("\(vehicle.prices.promoCode.uppercased())")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.top, 2)
                        
                        Text("Promo Code Active")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.bottom, 0.25)
                            .foregroundColor(.black)

//                            .padding(.bottom, 2)
                        
//                        Text("Savings ") +
//                        Text("$\(vehicle.prices.promoCodeSavings, specifier: "%.2f")")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                            .foregroundColor(.teal)
//                        +
                        Text("$\(vehicle.prices.promoCodeSavings, specifier: "%.2f")")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.teal)
                        
                        Text("Total Saved!")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.bottom, 1)
                    }
                    .padding(5)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .fill(Color.pink)
                            .shadow(color: .black,
                                     radius: 10, x: 0, y: 5)
                    )
                    .foregroundColor(.white)
//                    .padding(.top, 10)
                }
                
                Text(vehicle.getYearMakeModel())
                    .font(.body)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                Text(vehicle.serviceType)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                
                Text("Est Completion Time: \(hours.getTotalHoursLow()) - \(hours.getTotalHoursHigh()) hours")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 30)
                                                
                NavigationLink(
                    destination: ItemizedQuoteView(),
                    label: {
                        Text("Itemized Quote")
                        .font(.body)
                        .fontWeight(.semibold)
                    }
                )
                
                Button(action: {
                    promoModalShowing = true
                }, label: {
                    Text("Promo Code")
                        .fontWeight(.semibold)
                        .font(.footnote)
                })
                .padding(.top, 5)
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                    .frame(width: 280, height: 80)
                    .padding(.top, 40)
                
            }
            .offset(y: -30)
            .sheet(isPresented: $promoModalShowing, content: {
                PromoCodeView(order: self.order, modalShowing: $promoModalShowing, totalPrice: $totalPrice)
            })
            
        }
        .onAppear(perform: {
            self.totalPrice = vehicle.getTotalPrice()
            vehicle.totalPrice = self.totalPrice
        })
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
            .environmentObject(Order().sampleOrder())
    }
}

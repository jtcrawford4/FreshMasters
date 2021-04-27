//
//  QuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteView: View {
    
    @EnvironmentObject var order: Order
    
    var body: some View{
        
        let vehicle = order.vehicle
        let hours = vehicle.hours
        
        ZStack{
            
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea()
         
            VStack{
                
                Text("$ \(vehicle.getTotalPrice(), specifier: "%.2f")")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                    .padding(.bottom, 30)
                
                Text(vehicle.getYearMakeModel())
                    .font(.body)
                    .foregroundColor(.primary)
                    .fontWeight(.semibold)
                
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
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                    .frame(width: 280, height: 80)
                    .padding(.top, 40)
                
            }
            .offset(y: -50)
            
        }
    }
    
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
            .environmentObject(Order().sampleOrder())
    }
}

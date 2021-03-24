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
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
         
            VStack{
                
                Text("$ \(order.vehicle.getTotalPrice(), specifier: "%.2f")")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                
                Text(order.vehicle.getYearMakeModel())
                    .font(.body)
                    .fontWeight(.semibold)
                
                Text(order.vehicle.serviceType)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                                
                //MARK: - turn into detail/.screen
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Itemized Quote", isEnabled: true, content: {ItemizedQuoteView()})
                    .frame(width: 280, height: 80)
                    .padding(.top, 40)
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", isEnabled: true, content: {AppointmentView()})
                    .frame(width: 280, height: 80)
                    .padding(.top, 40)
                
            }
            
        }
    }
    
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}

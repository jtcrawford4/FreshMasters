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
//                Spacer()
                
                Text("$ \(order.vehicle.getTotalPrice(), specifier: "%.2f")")
                    .font(.system(size: 60))
                    .fontWeight(.bold)
                
                Text("$ \(549.99, specifier: "%.2f")")
                    .font(.system(size: 60))
                    .fontWeight(.bold)

//                Spacer()
                
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

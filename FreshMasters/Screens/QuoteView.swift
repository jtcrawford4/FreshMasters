//
//  QuoteView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteView: View {
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(Color.offWhite)
    }
    
    var body: some View {

            ZStack{
                
                Rectangle()
                    .fill(Color.offWhite)
                    .ignoresSafeArea()
                
                List{
                    QuoteCell(title: "Test", value: 100)
                    QuoteCell(title: "Test", value: 100)
                    QuoteCell(title: "Test", value: 100)
                    QuoteCell(title: "Test", value: 100)
                }
                .padding(.top)
                .navigationTitle("Itemized Quote")
                
                VStack{

                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Schedule Appointment", content: {AppointmentView()})
                        .frame(width: 280, height: 80)
                        .padding(.top, 40)
                    
                }
            }
            .background(Color.clear)

    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}

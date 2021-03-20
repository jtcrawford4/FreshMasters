//
//  AppointmentView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct ValidationView: View {
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Text("Everything looks good!")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                
                LinearGradient(.red, .pink)
                    .mask(Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width:100, height: 125)
                            .padding(100)
                    )
                    .frame(width:100, height: 125)
                    .shadow(color: .white, radius: 2, x: -3, y: -3)
                    .shadow(color: .gray, radius: 2, x: 3, y: 3)
                
                NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Quote", content: {QuoteView()})
                    .frame(width: 180, height: 80)
                    .padding(.top, 40)
            }
            .offset(y: -60)
            
        }
    }
}

struct ValidationView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationView()
    }
}

//
//  NavLinkButton.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct NavigationLinkButton<Content: View>: View{
    
    let desintation: () -> Content
    let buttonText: String
    let image: Image
    let isEnabled: Bool
        
    init(image: Image, buttonText: String, isEnabled: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.desintation = content
        self.buttonText = buttonText
        self.image = image
        self.isEnabled = isEnabled
    }
    
    var body: some View{
        NavigationLink(destination: desintation(),
           label: {
                HStack{
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.semibold)
                        .foregroundColor(isEnabled ? .black : .gray)
                    Spacer()
                    LinearGradient(
                        gradient: isEnabled ? Gradient(colors:[Color.red, Color.pink]) : Gradient(colors:[Color.gray, Color.gray]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .mask(image
                                .resizable()
                                .scaledToFit()
                                .frame(width:25, height: 25)
                                .padding(100)
                        )
                        .frame(width:25, height: 25)
                        .shadow(color: .white, radius: 2, x: -3, y: -3)
                        .shadow(color: .gray, radius: 2, x: 3, y: 3)
                }
           }
        )
        .buttonStyle(SquareButtonStyle())
    }
}

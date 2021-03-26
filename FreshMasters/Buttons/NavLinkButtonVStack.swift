//
//  NavLinkButtonVStack.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct NavLinkButtonVStack<Content: View>: View{
    
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
                VStack{
                    LinearGradient(
                        gradient: isEnabled ? Gradient(colors:[Color.red, Color.pink]) : Gradient(colors:[Color.gray, Color.gray]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .mask(image
                                .resizable()
                                .scaledToFit()
                                .frame(width:40, height: 40)
                                .padding(100)
                        )
                        .frame(width:60, height: 60)
                    
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.light)
                        .foregroundColor(isEnabled ? .black : .gray)
                        .multilineTextAlignment(.center)
                }
           }
        )
        .buttonStyle(SquareButtonStyle())
    }
}

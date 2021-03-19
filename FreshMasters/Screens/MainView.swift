//
//  MainView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/15/21.
//

import SwiftUI

extension LinearGradient{
    init(_ colors: Color...){
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct MainView: View {
    
    @State private var isToggled = false
    @State private var isPressed = false
    
    var body: some View {
        NavigationView{
            ZStack{
                
                Rectangle()
                    .fill(Color.offWhite)
                    .ignoresSafeArea()
                
                VStack{
                    
                    LinearGradient(.red, .pink)
                        .mask(Image(systemName: "location")
                                .resizable()
                                .scaledToFit()
                                .frame(width:100, height: 125)
                                .padding(100)
                        )
                        .frame(width:100, height: 125)
                        .shadow(color: .white, radius: 2, x: -3, y: -3)
                        .shadow(color: .gray, radius: 2, x: 3, y: 3)
                        .padding(.bottom)
                    
                    //                Text("AUTOMOTIVE DETAILING")
                    //                    .font(.title3)
                    //                    .fontWeight(.semibold)
                    //                    .foregroundColor(.darkStart)
                    //                    .italic()
                    
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Started", content: {VehicleTypeView()})
                        .frame(width: 250, height: 50)

                    .padding(40)
                    .buttonStyle(SquareButtonStyle())
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

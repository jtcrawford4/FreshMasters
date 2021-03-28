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
                        .mask(Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:150, height: 175)
                                .padding(100)
                        )
                        .frame(width:150, height: 175)
                        .shadow(color: .white, radius: 2, x: -3, y: -3)
                        .shadow(color: .gray, radius: 2, x: 3, y: 3)

                    
                                    Text("AUTOMOTIVE DETAILING")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.secondary)
                                        .italic()
                                        .padding(.bottom)
                                        .shadow(radius: 2, x: 0, y: -3)
                     
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Started", isEnabled: true, content: {VehicleTypeView()})
                        .frame(width: 200, height: 50)

                    .padding(40)
                    .buttonStyle(SquareButtonStyle())
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

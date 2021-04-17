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
    @State var safariModalPresented = false
    
    var body: some View {
        let safariURL = "http://freshmastersdetail.com/"
        NavigationView{
            ZStack{
                
                Rectangle()
                    .fill(Color.background)
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color.background, Color.backgroundShadow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .ignoresSafeArea()
                
                VStack{
                    
                    LinearGradient(.red, .pink)
                        .mask(Image("logo")
                                .resizable()
                                .scaledToFit()
                                .frame(width:150, height: 175)
                        )
                        .frame(width:150, height: 175)
                        .shadow(color: .backgroundHighlight, radius: 2, x: -3, y: -3)
                        .shadow(color: .backgroundShadow, radius: 2, x: 3, y: 3)

                    Text("AUTOMOTIVE DETAILING")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.bottom, 5)
                    
                    Button(action: {
                        safariModalPresented.toggle()
                    }, label: {
                        Text("freshmastersdetail.com")
                            .font(.caption)
                    })
                     
                    NavigationLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Started", isEnabled: true, content: {VehicleTypeView()})
                        .frame(width: 200, height: 50)
                    .padding(40)
                    
                }
            }
            .sheet(isPresented: $safariModalPresented) {
                SafariView(url:URL(string: safariURL)!)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.light)
    }
}

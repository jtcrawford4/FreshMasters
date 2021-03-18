//
//  MainView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/15/21.
//

import SwiftUI

extension Color{
    static let brandPrimary = Color(red: 255/255, green: 38/255, blue: 9/255)
    static let offWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    static let darkStart = Color(red: 50/255, green: 60/255, blue: 65/255)
    static let darkEnd = Color(red: 25/255, green: 25/255, blue: 30/255)
}

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
                    
                    NavLinkButton(image: Image(systemName: "chevron.right.circle.fill"), buttonText: "Get Started", content: {VehicleTypeView()})
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

//struct BorderedView<Content: View>: View {
//    let content: Content
//
//    init(@ViewBuilder content: () -> Content) {
//        self.content = content()
//    }
    
struct NavLinkButton<Content: View>: View{
    
    let desintation: () -> Content
    let buttonText: String
    let image: Image
        
    init(image: Image, buttonText: String, @ViewBuilder content: @escaping () -> Content) {
        self.desintation = content
        self.buttonText = buttonText
        self.image = image
    }
    
    var body: some View{
        NavigationLink(destination: desintation(),
           label: {
                HStack{
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.semibold)
                    Spacer()
                    LinearGradient(.red, .pink)
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
//        .frame(width: 250, height: 50)
    }
}

struct SquareButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(RoundedRectangle(cornerRadius: 8))
            .background(
                Group{
                    if configuration.isPressed {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.offWhite)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.offWhite)
                            .shadow(color: Color.black.opacity(0.2), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.6), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}

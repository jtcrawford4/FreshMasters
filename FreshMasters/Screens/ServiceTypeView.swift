//
//  ServiceTypeView.swift
//  FreshMasters
//
//  Created by John Crawford on 3/17/21.
//

import SwiftUI

struct ServiceTypeView: View {
    
    @State private var interiorIsToggled = false
    @State private var exteriorIsToggled = false
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .fill(Color.offWhite)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("What detailing services are needed?")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .multilineTextAlignment(.center)
                    .padding()
                
                HStack(spacing: 10){
                    VStack{
                        Button(action: {
                            print("interior")
                            interiorIsToggled.toggle()
                        }, label: {
                            VStack{
                                Image(systemName: "cart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(interiorIsToggled ? .red : .black)
                                    .padding(5)
                                Text("Interior")
                                    .font(.body)
                                    .fontWeight(.light)
//                                    .foregroundColor(interiorIsToggled ? .red : .black)
                            }
                            
                            
                        })
                        .buttonStyle(SquareButtonStyle())
                            
                    }
                    
                    VStack{
                        Button(action: {
                            print("exterior")
                            exteriorIsToggled.toggle()
                        }, label: {
                            
                            VStack{
                                Image(systemName: "cart")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 35, height: 35)
                                    .foregroundColor(exteriorIsToggled ? .red : .black)
                                    .padding(5)
                                Text("Exterior")
                                    .font(.body)
                                    .fontWeight(.light)
//                                    .foregroundColor(exteriorIsToggled ? .red : .black)
                            }
                            
                        })
//                            .shadow(color: .red, radius: 2, x: -3, y: -3)
                        .buttonStyle(SquareButtonStyle())
                                                    
                        
                    }
                    
                }
                .padding()
                
                NavLinkButton(imageName: "chevron.right.circle.fill", buttonText: "Next", content: {ServiceTypeView()})
                    .frame(width: 160, height: 80)
                    .padding(.top, 40)
                    
                Spacer()
            }
            .offset(y: -60)
        }
    }
}

struct ServiceTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceTypeView()
    }
}

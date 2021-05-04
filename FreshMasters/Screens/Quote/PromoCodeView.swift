//
//  PromoCodeView.swift
//  FreshMasters
//
//  Created by John Crawford on 5/3/21.
//

import SwiftUI

struct PromoCodeView: View {
    
    @EnvironmentObject var order: Order
    @State var promoCode = ""
    @State var validCode = false
    @Binding var modalShowing: Bool
    
    var body: some View {
        
        ZStack{
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brandPrimary, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .brightness(0.3)
                .ignoresSafeArea()
            
            VStack{
                
                Image("logo")
                    .resizable()
                    .frame(width: 60, height: 40)
                    .padding(.bottom, 40)
                    .brightness(1)
                
                Text("Promo Code")
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.title2)
                
                TextField("Code", text: $promoCode)
                    .padding(.trailing)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(4.0)
                    .padding(.horizontal, 60)
                    .font(.body)
                    .onChange(of: promoCode, perform: { value in
                        self.promoCode = promoCode.limit(characterLimit: 30, string: value)
                    })
                    .contrast(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 20)
                
//                Text("Invalid Code")
//                    .foregroundColor(.pink)
//                    .padding(.bottom, 40)
                
                VStack{
                    Button(action: {
                        validCode = order.vehicle.prices.submitPromoCode(code: promoCode)
                    }, label: {
                        Text("Apply")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    })
                    .frame(width: 180, height: 40)
                    .cornerRadius(4.0)
                    .background(Color.teal)
                    .padding(.bottom, 20)
                    
                    Button(action: {
                        modalShowing.toggle()
                    }, label: {
                        Text("Close")
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    })
                    .frame(width: 180, height: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke()
                            .foregroundColor(.white)
                    )
                }
                
            }
        }
    }
}

struct PromoCodeView_Previews: PreviewProvider {
    static var previews: some View {
        PromoCodeView(modalShowing: .constant(true))
    }
}

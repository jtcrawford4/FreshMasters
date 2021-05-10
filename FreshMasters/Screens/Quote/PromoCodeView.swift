//
//  PromoCodeView.swift
//  FreshMasters
//
//  Created by John Crawford on 5/3/21.
//

import SwiftUI

struct PromoCodeView: View {
    
    @ObservedObject var order: Order
    @State var promoCode = ""
    @State var isValidCode = false
    @Binding var modalShowing: Bool
    @Binding var totalPrice: Double
    
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
                
//                Text("Promo Code")
//                    .foregroundColor(.white)
//                    .fontWeight(.light)
//                    .font(.title2)
                
                TextField("Promo Code", text: $promoCode)
                    .frame(width: 280, height: 40)
                    .padding(.trailing)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .background(Color.white)
                    .cornerRadius(4.0)
                    .padding(.horizontal, 60)
                    .font(.body)
                    .onChange(of: promoCode, perform: { value in
                        self.promoCode = promoCode.limit(characterLimit: 20, string: value)
                    })
//                    .contrast(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 20)
                
//                Text("Invalid Code")
//                    .foregroundColor(.pink)
//                    .padding(.bottom, 40)
                
                VStack{
                    Button(action: {
                        let vehicle = order.vehicle
                        let prices = order.vehicle.prices
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                        isValidCode = prices.checkPromoCode(code: promoCode)
                        vehicle.prices.promoCodeSavings = 0
//                        vehicle.prices.hasValidPromoCode = isValidCode
                        vehicle.hasValidPromoCode = isValidCode
                        vehicle.totalPrice = vehicle.getTotalPrice()
                        totalPrice = vehicle.totalPrice
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
        PromoCodeView(order: Order().sampleOrder(), modalShowing: .constant(true), totalPrice: .constant(0))
    }
}

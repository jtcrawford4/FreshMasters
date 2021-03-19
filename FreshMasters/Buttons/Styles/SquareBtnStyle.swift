//
//  SquareBtnStyle.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

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

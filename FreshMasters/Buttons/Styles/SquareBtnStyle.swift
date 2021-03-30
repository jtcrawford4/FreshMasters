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
                            .fill(Color.background)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.backgroundShadow, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(Color.backgroundShadow, Color.clear)))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.backgroundHighlight, lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2)
                                    .mask(RoundedRectangle(cornerRadius: 8).fill(LinearGradient(Color.clear, Color.backgroundShadow)))
                            )
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.background)
                            .shadow(color: Color.backgroundShadow.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 10, y: 10)
                            .shadow(color: Color.backgroundHighlight, radius: 10, x: -2, y:-2)
                    }
                }
            )
    }
}

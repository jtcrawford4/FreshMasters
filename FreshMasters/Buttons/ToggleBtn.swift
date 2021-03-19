//
//  ToggleBtn.swift
//  FreshMasters
//
//  Created by John Crawford on 3/18/21.
//

import SwiftUI

struct ToggleButton: View{
    
    @Binding var toggleState: Bool
    var imageToggled: Image
    var imageNotToggled: Image
    var buttonText: String
    
    var body: some View{
        VStack{
            Button(action: {
                toggleState.toggle()
            }, label: {
                VStack{
                    (toggleState ? imageToggled : imageNotToggled)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 35, height: 35)
                        .padding(5)
                    Text(buttonText)
                        .font(.body)
                        .fontWeight(.light)
                        .multilineTextAlignment(.center)
                }
            })
            .buttonStyle(SquareButtonStyle())
        }
    }
}

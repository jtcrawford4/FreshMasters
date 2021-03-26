//
//  TitleText.swift
//  FreshMasters
//
//  Created by John Crawford on 3/26/21.
//

import SwiftUI

struct TitleText: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.title3)
            .fontWeight(.semibold)
            .padding()
            .multilineTextAlignment(.center)
            .padding()
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText(text: "Test")
    }
}

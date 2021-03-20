//
//  QuoteCell.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteCell: View {
    
    @State var title: String
    @State var value: Double
    
    var body: some View {
        HStack{
            Text(title)
            Spacer()
            Text("$\(value, specifier: "%.2f")")
        }
        .listRowBackground(Color.offWhite)
    }
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCell(title: "Title", value: 24)
    }
}

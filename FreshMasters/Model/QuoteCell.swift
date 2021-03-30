//
//  QuoteCell.swift
//  FreshMasters
//
//  Created by John Crawford on 3/19/21.
//

import SwiftUI

struct QuoteCell: View {
    
    @State var title: String
    @State var value: Any
    
    var body: some View {
        HStack{
            Text(title)
                .fontWeight("Total" == title ? .semibold : .regular)
                .foregroundColor("Total" == title ? .black : .secondary)
            Spacer()
            if value is String{
                Text(value as! String)
            }else if value is Double{
                Text("$\(value as! Double, specifier: "%.2f")")
            }else{
                
            }
            
        }
        .listRowBackground(Color.background)
    }
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCell(title: "Title", value: "24")
    }
}

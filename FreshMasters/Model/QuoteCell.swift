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
            Spacer()
//            Text("$\(value, specifier: "%.2f")")
            if value is String{
                Text(value as! String)
            }else if value is Double{
                Text("\(value as! Double, specifier: "%.2f")")
            }else{
                
            }
            
        }
        .listRowBackground(Color.offWhite)
    }
}

struct QuoteCell_Previews: PreviewProvider {
    static var previews: some View {
        QuoteCell(title: "Title", value: "24")
    }
}

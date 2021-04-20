//
//  StringExtension.swift
//  FreshMasters
//
//  Created by John Crawford on 4/19/21.
//

import Foundation

extension String {
   
    var isNumeric: Bool {
     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
    }
    
    func limit(characterLimit: Int, string: String) -> String{
        if(string.count > characterLimit){
            return String(string.prefix(characterLimit))
        }
        return string
    }
    
}

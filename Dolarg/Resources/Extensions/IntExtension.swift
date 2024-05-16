//
//  IntExtension.swift
//  Dolarg
//
//  Created by Guimel Moreno on 15/05/24.
//

import Foundation

extension Int {
    func separadorDeMil() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let numberString = formatter.string(from: NSNumber(value: self)) {
            return numberString
        }
        
        return String(self)
    }

}

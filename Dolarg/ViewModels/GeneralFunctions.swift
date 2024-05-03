//
//  GeneralFunctions.swift
//  Dolarg
//
//  Created by Gaston Foncea on 03/05/2024.
//

import Foundation


class GeneralFunctions: ObservableObject {
    
    //Funciones que usaremos en toda la app
    
    func AnyToInt(dato: Any) -> Int {
        if let intValue = dato as? Int {
            return intValue
        } else{
            return 0
        }
    }
    
    
}

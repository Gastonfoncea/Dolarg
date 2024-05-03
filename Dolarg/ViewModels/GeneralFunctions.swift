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
    
    func DateTimeActualizado(time:String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = dateFormatter.date(from: time) {
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let timeString = timeFormatter.string(from: date)
            return timeString
            
        } else {
            print("error al convertir la hora")
            return("")
        }
    }
    
    
}

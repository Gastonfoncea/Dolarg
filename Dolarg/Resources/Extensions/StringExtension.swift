//
//  StringExtension.swift
//  Dolarg
//
//  Created by Guimel Moreno on 15/05/24.
//

import Foundation

extension String {
    func AnyToInt(dato: Any) -> Int {
        if let intValue = dato as? Int {
            return intValue
        } else{
            return 0
        }
    }
    
    func DateTimeActualizado() -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let date = dateFormatter.date(from: self) {
            
            let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "HH:mm"
            
            let timeString = timeFormatter.string(from: date)
            return timeString
            
        } else {
            print("error al convertir la hora")
            return("")
        }
    }
    
    //de 2024-04-06 a 06-04
    func formaterTimeChart() -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd" //formato de entrada
        
        if let date = dateFormatter.date(from: self) {
            
            dateFormatter.dateFormat = "dd-MM" //formato de salida
            
            let formatedDate = dateFormatter.string(from: date) //formateamos la fecha
            return formatedDate
        } else {
            return "error"
        }
    }
}

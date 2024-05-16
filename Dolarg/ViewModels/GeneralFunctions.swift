//
//  GeneralFunctions.swift
//  Dolarg
//
//  Created by Gaston Foncea on 03/05/2024.
//

import Foundation
import Observation


@Observable class GeneralFunctions {
    
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
            timeFormatter.dateFormat = "dd/MM HH:mm"
            
            let timeString = timeFormatter.string(from: date)
            return timeString
            
        } else {
            print("error al convertir la hora")
            return("")
        }
    }
    
    //de 2024-04-06 a 06-04
    func formaterTimeChart(fecha: String) -> String {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd" //formato de entrada
        
        if let date = dateFormatter.date(from: fecha) {
            
            dateFormatter.dateFormat = "dd-MM" //formato de salida
            
            let formatedDate = dateFormatter.string(from: date) //formateamos la fecha
            return formatedDate
        } else {
            return "error"
        }
    }
    
    func separadorDeMil(num: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let numberString = formatter.string(from: NSNumber(value: num)) {
            return numberString
        }
        
        return String(num)
    }
    
    
    
    func MesEnCurso() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "MMMM"
        return formatter.string(from: Date())
    }
    
    func diaEnCurso() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: Date())
    }
    
    
    
    
}

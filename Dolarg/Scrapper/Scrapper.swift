//
//  Scrapper.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation
import SwiftSoup

class Scrapper: ObservableObject {
    
    
    let baseUrl = "https://dolarhoy.com"
    var array: [Any] = []
    @Published var montoCompraBlue: Any = ""
    @Published var montVentaBlue: Any = ""
    
    ///FUNCIONES
    func scrappearDolar() {
        //URLSession par hacerlo de forma async
        guard let url = URL(string: baseUrl) else {
            print("Url invalida")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { [self]data,response, error in
            
            if let error = error {
                print("\(error)")
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Respuesta no válida")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Respuesta no válida")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error en la respuesta: \(httpResponse.statusCode)")
                return
            }
            
            ///Si el llamado funciona
            if let data = data {
                print("Datos recibidos: \(data)")
                
                //manejamos el html conseguido por la url
                if String(data:data, encoding: .utf8) != nil {
                    do {
                        //Obtener contenido html
                        let html = try String(contentsOf: url)
                        
                        //Crear un objeto documento para analizar el HTML
                        let document: Document = try SwiftSoup.parse(html)
                        
                        //Buscar elementos con la clase especifica "val"
                        let valoresDolar = try document.getElementsByClass("val")
                        
                        //iteramos los valores en un bucle for
                        for element in valoresDolar {
                            let text = try element.text()
                            try array.append(element.text())
                            print("valor encontrado \(text)")
                            
                        }
                        print(array)
                        montoCompraBlue = array[0]
                        montVentaBlue = array[1]
                        
                    } catch {
                        print("Error al screappear shit")
                    }
                }
                
            } else {
                print("No se recibieron datos")
            }
        }
        task.resume()
    }
    
    
}


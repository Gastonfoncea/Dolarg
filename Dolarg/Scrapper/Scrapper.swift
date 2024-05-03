//
//  Scrapper.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation
import SwiftSoup




class Scrapper {
    
    static let shared = Scrapper()
    let baseUrl = "https://dolarhoy.com"
    @Published var array: [Any] = []

  
    
    ///FUNCIONES
    func scrappearDolar(completed:@escaping(Result<DolarModel,NetworkErrors>)->Void ) {
        //URLSession par hacerlo de forma async
        guard let url = URL(string: baseUrl) else {
            print("Url invalida")
            completed(.failure(.invalidResponse))
            return
        }
        
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data,response, error in
            
            if let error = error {
                print("\(error)")
                completed(.failure(.unableToComplete))
                
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Respuesta no válida")
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Respuesta no válida")
                completed(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error en la respuesta: \(httpResponse.statusCode)")
                completed(.failure(.invalidResponse))
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
                            try self.array.append(element.text())
                            print("valor encontrado \(text)")
                            
                        }
                        print(self.array)
                        completed(.success(DolarModel(array: self.array)))
               
                    } catch {
                        print("Error al screappear shit")
                    }
                }
                
            } else {
                print("No se recibieron datos")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
}

/*
 valor encontrado $1020 0 blue compra
 valor encontrado $1040 1 blue venta
 valor encontrado $1020 2 blue
 valor encontrado $1040 3 blue
 valor encontrado $897 4 oficial compra
 valor encontrado $897 5 oficial venta
 valor encontrado $1064.60 6 bolsa compra
 valor encontrado $1069.10 7 bolsa venta
 valor encontrado $1107.30 8 liqui compra
 valor encontrado $1111.20 9 liqui venta
 valor encontrado $1086 10 cripto compra
 valor encontrado $1104 11 cripto venta
 valor encontrado $1435.20 12 tarjeta
 */


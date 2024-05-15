//
//  ScrapHistorico.swift
//  Dolarg
//
//  Created by Gaston Foncea on 14/05/2024.
//

import Foundation
import SwiftSoup

class ScrapHistorico {
    
    static let shared = ScrapHistorico() //Singleton
    let historicoUrl = "https://www.bloomberglinea.com/mercados/argentina/dolar-blue-hoy/"
    var arrayFechaH = [String]()
    var arrayMontosH = [String]()
    var arrayModificado = [String]()
    
    //MARK: HISTORICO
    func scrapearHistoricoDolar(completed: @escaping(Result<HistoricoModel,NetworkErrors>)-> Void ) {
        
        guard let url = URL(string: historicoUrl) else {
            print("Url Invalida")
            completed(.failure(.invalidResponse))
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) {data, response, error in
            
            if let error = error {
                print("\(error)")
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("respuesta no valida")
                completed(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("Error en la respuesta: \(response.statusCode)")
                completed(.failure(.invalidResponse))
                return
            }
            
            
            if let data = data {
                print("succes \(data)")
                
                //logica para scrapear los datos de la web
                
                //manejamos el html conseguido por la url
                if String(data:data, encoding: .utf8) != nil {
                    
                    do{
                        //obtener contenido html
                        let html = try String(contentsOf: url)
                        
                        //crear un document para poder scrapear los datos
                        let document: Document = try SwiftSoup.parse(html)
                        
                        //buscamos la tabla
                        let table = try document.select("table.container-fluid").first()
                        //iteramos sobre los elementos
                        if let rows = try table?.select("tr") {
                            for row in rows {
                                let cells = try row.select("td")
                                for cell in cells {
                                    let cellText = try cell.text()
                                   // print(cellText)
                                    if cellText.count == 10 {
                                        self.arrayFechaH.append(cellText)
                                    } else {
                                        
                                        self.arrayMontosH.append(cellText)
                                    }
                                   
                                }
                            }
                        }
                        
                        var n = 1
                        //tratamos el array para solo agregar los montos de venta
                        for element in stride(from:n,to:self.arrayMontosH.count, by:2) {
                            self.arrayModificado.append(self.arrayMontosH[element])
                            n += 2
                        }
                        // print("\(self.arrayFechaH)")
                       // print("ARRAY HISTORICO \(arrayModificado)")
                        completed(.success(HistoricoModel(arrayFechas: self.arrayFechaH, arrayMontos: self.arrayModificado)))
                    } catch {
                        print("No se recibieron datos")
                        completed(.failure(.invalidData))
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
}

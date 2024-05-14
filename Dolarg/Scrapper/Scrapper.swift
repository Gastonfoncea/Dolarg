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
    let baseUrl = "https://www.infodolar.com"
    let historicoUrl = "https://www.bloomberglinea.com/mercados/argentina/dolar-blue-hoy/"
    var array: [String] = []
    var arrayFechaH = [String]()
    var arrayMontosH = [String]()
    
    var arrayLocal: [String] = []

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
                        
                        ///Scrap monto de los dolares
                        //buscamos los valores que tengan la etiquieta siguiente
                        let valoresDolar = try document.select("td.colCompraVenta")
                        
                        ///Scrap fecha de actualizacion
                        let timeActualizacion = try document.select("span.time abbr.timeago").first()
                        let textActualiacion = try timeActualizacion?.attr("title")
                        
                        
                        //iteramos los valores en un bucle for
                        for element in valoresDolar {
                            let text = try element.attr("data-order")
                            self.array.append(text)
                           // print("valor encontrado \(text)")
                            
                        }
                       // print(self.array)
                        completed(.success(DolarModel(array: self.array, actualizacion: textActualiacion ?? "Acualizando")))
               
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
                        var arrayModificado = [String]()
                        var n = 1
                        //tratamos el array para solo agregar los montos de venta
                        for element in stride(from:n,to:self.arrayMontosH.count, by:2) {
                            arrayModificado.append(self.arrayMontosH[element])
                            n += 2
                        }
                        // print("\(self.arrayFechaH)")
                        //print("\(arrayModificado)")
                        completed(.success(HistoricoModel(arrayFechas: self.arrayFechaH, arrayMontos: arrayModificado)))
                    } catch {
                        print("No se recibieron datos")
                        completed(.failure(.invalidData))
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    ///FUNCION CREADA LOCAL
    //MARK: SRAP LOCAL
    //realizar una funcion que scrapee localmente a un json que tengamos en la mac, para poder testear las actualizaciones
    func scrappearLocal(completed: @escaping(Result<DolarLocalModel,NetworkErrors>) -> Void ) {
        
        //pasamos los parametros para que busque en el archivo local
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else{
            return
        }
        
        let url2 = URL(fileURLWithPath: path)
        var dolar: DolarLocalModel?
        
        do {
            let jsonData = try Data(contentsOf: url2)
            dolar = try JSONDecoder().decode(DolarLocalModel.self, from: jsonData)
            
            if let dolar = dolar {
                //print(dolar)
                self.arrayLocal = dolar.array
                print(self.arrayLocal)
                completed(.success(DolarLocalModel(array: self.arrayLocal)))
            }
        } catch {
            print("error")
            completed(.failure(.invalidData))
        }
       
    }
    
}



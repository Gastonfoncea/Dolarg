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
    let historicoUrl = "https://www.ambito.com/contenidos/dolar-informal-historico.html"
    @Published var array: [String] = []
    @Published var arrayHistoricos: [Any] = []

   
    
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
            
//            guard response is HTTPURLResponse else {
//                print("Respuesta no válida")
//                completed(.failure(.invalidResponse))
//                return
//            }
            
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
                            print("valor encontrado \(text)")
                            
                        }
                        print(self.array)
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
                        
                        let historicos = try document.select("tbody.general-historical__tbody.tbody")
                        
                        for historico in historicos {
                            self.arrayHistoricos.append(historico)
                        }
                        print("\(self.arrayHistoricos)")
                        completed(.success(HistoricoModel(array: self.arrayHistoricos)))
                        
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



//
//  DolarViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation
import Observation


@Observable class DolarViewModel {
    
    //var dolarLocal: DolarLocalModel?
    var historicoDolar: HistoricoModel?
    var dolar: DolarModel?
    var isLoading = true
    var isLoadingHistorico = true
    var error: Error?
    var errorH: Error?
    private var timer: Timer?
    
    
    //inicializamos el timer con la funcion fetch dolar para que realice la peticion cada 300 segundos, a su vez la llamamos como weak Self para que no haga una fuga de memoria
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
            self?.fetchDolar()
        }
        fetchDolar()
    }
    
    // Detener el temporizador cuando se destruya el ViewModel para evitar fugas de memoria
    deinit {
        timer?.invalidate()
    }
    
        func fetchDolar() {
           print("Scrapeando datos blue")
            Scrapper.shared.scrappearDolar() {result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch result {
                    case .success(let data):
                        self.dolar = data
                        
                    case .failure(let error):
                        self.error = error
                        print("Error\(error)")
                    }
                }
                
            }
            
        }
        
        
        
        func fetchHistorico() {
           // print("scrapeando Historico")
            Scrapper.shared.scrapearHistoricoDolar() {result in
                DispatchQueue.main.async {
                    self.isLoadingHistorico = false
                    
                    switch result {
                    case .success(let data):
                        print("Entro en el historico")
                        self.historicoDolar = data
                        
                    case .failure(let error):
                        self.error = error
                        print("Error\(error)")
                    }
                }
            }
        }
    
    
    ///FUNCION CREADA LOCAL
    /*
     func fetchLocal() {
         Scrapper.shared.scrappearLocal() { result in
             DispatchQueue.main.async {
                 switch result {
                 case .success(let data):
                     print(data)
                     self.dolarLocal = data
                     print("Lo logramos perra")
                     
                 case .failure(let error):
                     self.error = error
                     print("hemos fracasau")
                 }
             }
         }
     }
     */


    
    
    
    
}

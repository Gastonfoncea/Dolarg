//
//  DolarViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation
import Observation


class DolarViewModel: ObservableObject {
    


//    @Published var dolar: DolarModel?
    @Published var isLoading = true
    @Published var error: Error?
    @Published private var timer: Timer?
    
    
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
                        break
//                        self.dolar = data
                        
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

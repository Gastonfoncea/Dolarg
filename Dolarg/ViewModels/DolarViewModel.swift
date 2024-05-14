//
//  DolarViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation


class DolarViewModel: ObservableObject {
    
    @Published var dolarLocal: DolarLocalModel?
    @Published var historicoDolar: HistoricoModel?
    @Published var dolar: DolarModel?
    @Published var isLoading = true
    @Published var isLoadingHistorico = true
    @Published var error: Error?
    @Published var errorH: Error?
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
       print("Scrapeando datos como un hacker")
        Scrapper.shared.scrappearDolar() {result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let data):
                    print(self.dolar?.array ?? "")
                    self.dolar = data
                    
                case .failure(let error):
                    self.error = error
                    print("Error\(error)")
                }
            }
            
        }
        
    }
    
    
    
    func fetchHistorico() {
        //print("el historico crack")
        Scrapper.shared.scrapearHistoricoDolar() {result in
            DispatchQueue.main.async {
                self.isLoadingHistorico = false
                
                switch result {
                case .success(let data):
                    self.historicoDolar = data
                    
                case .failure(let error):
                    self.error = error
                    print("Error\(error)")
                }
            }
        }
    }
    
    
    ///FUNCION CREADA LOCAL
    func fetchLocal() {
        Scrapper.shared.scrappearLocal() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("no puedo creer")
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
    
    
    
    
}

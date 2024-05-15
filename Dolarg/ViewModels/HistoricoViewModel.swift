//
//  HistoricoViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 14/05/2024.
//

import Foundation

class HistoricoViewModel:ObservableObject {
    
    @Published var isLoadingHistorico = true
    @Published var historicoDolar: HistoricoModel?
    @Published var error: Error?
    
    
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
}

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
    @Published private var timer: Timer?
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
            self?.fetchHistorico()
        }
        fetchHistorico()
    }
    
    // Detener el temporizador cuando se destruya el ViewModel para evitar fugas de memoria
    deinit {
        timer?.invalidate()
    }
    
    
    func fetchHistorico() {
        print("scrapeando Historico")
        ScrapHistorico.shared.scrapearHistoricoDolar() {result in
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

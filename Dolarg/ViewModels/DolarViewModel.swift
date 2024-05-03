//
//  DolarViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 02/05/2024.
//

import Foundation


class DolarViewModel: ObservableObject {
    
    
    
    @Published var dolar: DolarModel?
    @Published var dolarOficial: DolarModel?
    @Published var isLoading = true
    @Published var error: Error?
    
    
    func fetchDolar() {
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
    
}

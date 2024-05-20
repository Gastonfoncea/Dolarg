//
//  HomeViewModel.swift
//  Dolarg
//
//  Created by Gaston Foncea on 20/05/2024.
//

import Foundation


//enumeramos los estados que puede tener el viewModel a la hora de iniciar la app - se utiliza @MainActor para que los casos se manejen en el hilo principal y se vean reflejados en la UI
@MainActor enum HomeViewState {
    case loading
    case loaded(HomeViewData)
    case error
}


//Creamos una struct para los datos que puede tener el viewModel
struct HomeViewData {
    var dolar: DolarModel?
    var historicoDolar: HistoricoModel?
}


//creamos el protocolo para obtener el estado en el que esta el viewModel. Es observable Object por lo que la case HomeViewModel va a heredar la observacion
protocol HomeViewProtocol: ObservableObject {
    var state: HomeViewState { get }
    func refreshAll()
}


class HomeViewModel {
    
    @Published private(set) var state: HomeViewState // esta es a la variable que vamos a acceder desde la vista
    
    private var viewData: HomeViewData?
    private var dolar: DolarModel?
    private var historicoDolar: HistoricoModel?
    
    init() {
        self.state = .loading
        self.viewData = HomeViewData()
        fetchHistorico()
        fetchDolar()
    }
}


extension HomeViewModel: HomeViewProtocol {
    func refreshAll() {
        state = .loading
        fetchHistorico()
        fetchDolar()
    }
}

private extension HomeViewModel {
    
    func prepareViewData() {
        var newViewData = HomeViewData()
        
        if let dolar {
            newViewData.dolar = dolar
        }
        
        if let historicoDolar  {
            newViewData.historicoDolar = historicoDolar
        }
        
        self.viewData = newViewData
        DispatchQueue.main.async {
            self.state = .loaded(newViewData)
        }
    }
    
    
    func fetchDolar() {
       print("Scrapeando datos blue")
        Scrapper.shared.scrappearDolar() {result in
            DispatchQueue.main.async { [weak self] in

                switch result {
                case .success(let data):
                    self?.dolar = data
                    self?.prepareViewData()
                    
                case .failure(let error):
                    self?.state = .error
                    print("Error\(error)")
                }
            }
        }
    }
    
    
    func fetchHistorico() {
        print("Scrapeando Historico")
        ScrapHistorico.shared.scrapearHistoricoDolar() {result in
            DispatchQueue.main.async { [weak self] in
                
                switch result {
                case .success(let data):
                    self?.historicoDolar = data
                    self?.prepareViewData()
                    
                case .failure(let error):
                    self?.state = .error
                    print("ERROR\(error)")
                }
                
            }
            
            
        }
    }
    
    
}

//
//  HomeViewModel.swift
//  Dolarg
//
//  Created by Guimel Moreno on 15/05/24.
//

import Foundation

/**
 Como buena práctica el nombramiento de clases deben seguir con el nombre del módulo,
 si tu pantalla/módulo se llama Home el nombramiento debe quedar:
 - HomeView.swift
 - HomeViewModel.swift
 */

//enumeramos los estados que puede estar el viewModel
@MainActor enum HomeViewState {
    case loading
    case loaded(HomeViewData)
    case error
}

//Los datos que puede tener el viewModel
struct HomeViewData {
    var dolar: DolarModel?
    var historicoDolar: HistoricoModel?
}

//protocolo para obtener el estado en el que esta el viewMOdel. Este es el objecto que llamaraemos ya que es el ObservableObject
protocol HomeViewModelProtocol: ObservableObject {
    var state: HomeViewState { get }
    func refreshAll()
}

//se puede instanciar el homeViewModel por que cumple con el protocolo de arriba y ers ObservableObject, por eso no hace falta declararlo aca
class HomeViewModel {
    @Published private(set) var state: HomeViewState
    
    private var viewData: HomeViewData?
    private var dolar: DolarModel?
    private var historicoDolar: HistoricoModel?
    private var timer: Timer?
    
    init() {
        self.state = .loading
        self.viewData = HomeViewData()
        fetchDolar()
        fetchHistorico()
        prepareTimer()
    }
    
    deinit {
        self.timer?.invalidate()
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func refreshAll() {
        self.timer?.invalidate()
        state = .loading
        fetchDolar()
        fetchHistorico()
    }
}

private extension HomeViewModel {
    
    func prepareViewData() {
        var newViewData = HomeViewData()
        
        if let dolar {
            newViewData.dolar = dolar
        }
        
        if let historicoDolar {
            newViewData.historicoDolar = historicoDolar
        }
        
        self.viewData = newViewData
        DispatchQueue.main.async {
            self.state = .loaded(newViewData)
        }
    }
    
    func prepareTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 300, repeats: true) { [weak self] _ in
            self?.fetchDolar()
            self?.fetchHistorico()
        }
        timer?.fire()
    }
    
    func fetchDolar() {
        print("Scrapeando datos blue")
        Scrapper.shared.scrappearDolar() { result in
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
        print("scrapeando Historico")
        ScrapHistorico.shared.scrapearHistoricoDolar() {result in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let data):
                    print("Entro en el historico")
                    self?.historicoDolar = data
                    self?.prepareViewData()
                    
                case .failure(let error):
                    self?.state = .error
                    print("Error\(error)")
                }
            }
        }
    }
}

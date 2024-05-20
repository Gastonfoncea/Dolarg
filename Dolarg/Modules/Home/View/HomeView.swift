//
//  Home.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI
import SwiftSoup
import Charts

struct HomeView: View {
    /**
     En MVVM, el View solo puede tener un solo ViewModel
     */
    @ObservedObject private var viewModel: HomeViewModel
    
    
    init() {
        viewModel = HomeViewModel()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ColorBackGround()
                    .ignoresSafeArea(.all)
                
                
                ScrollView {
                    VStack(spacing:15) {
                        HStack{
                            Text("Hola, bienvenido !")
                                .foregroundStyle(.white)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        switch viewModel.state {
                        case .loading:
                            ChartLoading()
                                .padding(.bottom)
                            DolarCardLoading()
                                .padding(.top)
                                .padding(.top)
                            DolarCardLoading()
                            DolarCardLoading()
                            DolarCardLoading()
                        case .loaded(let viewData):
                            createMainView(viewData: viewData)
                                .padding(.bottom)
                        case .error:
                            ContentUnavailableView("Error en la red", systemImage: "network.slash")
                        }
                    }
                    .padding(.horizontal,15)
                    .padding(.top,50)
                }
                .scrollIndicators(.hidden)
            }
            
        }
        .refreshable {
            viewModel.refreshAll()
        }
    }
}

private extension HomeView {
    
    func createMainView(viewData: HomeViewData) -> some View {
        guard let historicoDolar = viewData.historicoDolar else { return AnyView(Text("No Data")) }
        return AnyView(VStack(alignment: .leading, spacing: 10, content: {
            ChartView(dolarHistoricoData: historicoDolar)
            Text("Precio dolar hoy !")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.white)
                .padding(.top, 25)
            if let dolarData = viewData.dolar {
                CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[0], montoVenta: dolarData.array[1], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Mep", montoCompra: dolarData.array[6], montoVenta: dolarData.array[7], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Ahorro", montoCompra: dolarData.array[18], montoVenta: dolarData.array[19], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Tarjeta", montoCompra: dolarData.array[21], montoVenta: dolarData.array[22], horaActualizacion: dolarData.actualizacion)
            }
        }))
    }
    
}

#Preview {
    HomeView()
}


extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}

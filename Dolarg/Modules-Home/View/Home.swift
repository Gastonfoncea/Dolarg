//
//  Home.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI
import SwiftSoup
import Charts

struct Home: View {
    
    var genFunc = GeneralFunctions()
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
                        
                        //manejamos los casos en que puede estar el viewModel
                        switch viewModel.state {
                        case .loading:
                            ChartLoading()
                                .padding(.bottom,48)
                            DolarCardLoading()
                            DolarCardLoading()
                            DolarCardLoading()
                            DolarCardLoading()
                            
                        case .loaded(let viewData):
                            createMainViewChart(viewData: viewData)
                                .padding(.bottom)
                            createMainViewDolarCard(viewData: viewData)
                            
                        case .error:
                            ContentUnavailableView("error en la red", systemImage: "network.slash")
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


private extension Home {
    
    func createMainViewChart(viewData: HomeViewData) -> some View {
        guard let historicoDolar = viewData.historicoDolar else {return AnyView(Text("No data"))}
        return AnyView(VStack(alignment: .leading,spacing: 10, content: {
            ChartView(dolarHistoricoData: historicoDolar)
        }))
    }
    
    
    func createMainViewDolarCard(viewData: HomeViewData) -> some View {
        return AnyView(VStack(alignment: .leading,spacing: 15, content: {
            HStack{
                Text("Precio dolar hoy !")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(.white)
                Spacer()
            }
            if let dolarData = viewData.dolar {
                CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[0], montoVenta: dolarData.array[1], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Mep", montoCompra: dolarData.array[6], montoVenta: dolarData.array[7], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[18], montoVenta: dolarData.array[19], horaActualizacion: dolarData.actualizacion)
                CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[21], montoVenta: dolarData.array[22], horaActualizacion: dolarData.actualizacion)
                
            }
        }))
    }
    
}


#Preview {
    Home()
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

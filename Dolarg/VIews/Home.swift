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
    
    @StateObject var genFunc = GeneralFunctions()
    @EnvironmentObject var dolarVm : DolarViewModel
    
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
                            
                            ChartView()
                                .padding(.bottom)
                                HStack{
                                    Text("Precio dolar hoy !")
                                        .font(.callout)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                
                            
                                //Tarjeta dolar Blue
                                if dolarVm.isLoading{
                                    DolarCardLoading()
                                } else if dolarVm.error != nil {
                                    ContentUnavailableView("Error en la red", systemImage: "network.slash")
                                } else if let dolarData = dolarVm.dolar {
                                    CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[0], montoVenta: dolarData.array[1], horaActualizacion: dolarData.actualizacion)
                                }
                                
                                //Dolar Mep
                                if dolarVm.isLoading{
                                    DolarCardLoading()
                                } else if dolarVm.error != nil {
                                    ContentUnavailableView("Error en la red", systemImage: "network.slash")
                                } else if let dolarData = dolarVm.dolar {
                                    CardPrincipal(tipoDolar: "Dolar Mep", montoCompra: dolarData.array[6], montoVenta: dolarData.array[7], horaActualizacion: dolarData.actualizacion)
                                }
                                
                                
                                //Dolar Ahorro
                                if dolarVm.isLoading{
                                    DolarCardLoading()
                                } else if dolarVm.error != nil {
                                    ContentUnavailableView("Error en la red", systemImage: "network.slash")
                                } else if let dolarData = dolarVm.dolar {
                                    CardPrincipal(tipoDolar: "Dolar Ahorro", montoCompra: dolarData.array[18], montoVenta: dolarData.array[19], horaActualizacion: dolarData.actualizacion)
                                }
                                
                                //Dolar Tarjeta
                                if dolarVm.isLoading{
                                    DolarCardLoading()
                                } else if dolarVm.error != nil {
                                    ContentUnavailableView("Error en la red", systemImage: "network.slash")
                                } else if let dolarData = dolarVm.dolar {
                                    CardPrincipal(tipoDolar: "Dolar Tarjeta", montoCompra: dolarData.array[21], montoVenta: dolarData.array[22], horaActualizacion: dolarData.actualizacion)
                                }
                        }
                        .padding(.horizontal,15)
                        .padding(.top,50)
                }
                .scrollIndicators(.hidden)
            }
            
        }
        .refreshable {
            dolarVm.fetchHistorico()
            dolarVm.fetchDolar()
        }
        
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)){ _ in
            dolarVm.fetchDolar()
        }
    }
    
        
}

#Preview {
    Home()
        .environmentObject(DolarViewModel())
       
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

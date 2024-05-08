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
    
    @EnvironmentObject var dolarVm : DolarViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ColorBackGround()
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack(spacing:30) {
                        //MARK: Vista color animado
                        ZStack {
                            VStack{
                                HStack{
                                    Text("Mayo")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.white)
                                    Spacer()
                                }
                                ChartView()
                            }
                            
                        }
                        .padding(.horizontal,20)
                        //MARK: Vista color Blanco
                        ZStack {
                            WhiteCardBackGround()
                            VStack{
                                HStack{
                                    Text("Precio dolar hoy")
                                        .font(.title3)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.colorText2)
                                    Text(" 08-05-2024")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.gray)
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
                            .padding(.top,-240)
                            .padding(.horizontal,20)
                                
                                
                            
                        }
                      
                    }
                    .padding(.top,80)
                  
                }
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

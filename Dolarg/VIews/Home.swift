//
//  Home.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI
import SwiftSoup

struct Home: View {
    
   @StateObject var dolarVm = DolarViewModel()
    
    var body: some View {
        NavigationStack{
            
            VStack(spacing:20) {
                HStack{
                    Text("Dolarg 🇦🇷")
                        .font(.title)
                        .fontWeight(.semibold)
                    Spacer()
                }
               
                Spacer()
                HStack{
                    Text("Precio dolar hoy")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.colorText2)
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
            .padding(.top,50)
            //.navigationTitle("Dolarg 🇦🇷")
        }
        .padding()
        .onAppear {
           // dolarVm.fetchDolar()
            dolarVm.fetchHistorico()
        }
    }
        
}

#Preview {
    Home()
       
}

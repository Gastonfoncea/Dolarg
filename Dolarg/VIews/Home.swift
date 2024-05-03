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
        VStack(spacing:20) {
            
            //Tarjeta dolar Blue
            if dolarVm.isLoading{
                DolarCardLoading()
            } else if dolarVm.error != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarData = dolarVm.dolar {
                CardPrincipal(tipoDolar: "Dolar Blue", montoCompra: dolarData.array[0], montoVenta: dolarData.array[1])
            }
            
            //Dolar Mep
            if dolarVm.isLoading{
                DolarCardLoading()
            } else if dolarVm.error != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarData = dolarVm.dolar {
                CardPrincipal(tipoDolar: "Dolar Mep", montoCompra: dolarData.array[6], montoVenta: dolarData.array[7])
            }
            
            
            //Dolar Ahorro
            if dolarVm.isLoading{
                DolarCardLoading()
            } else if dolarVm.error != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarData = dolarVm.dolar {
                CardPrincipal(tipoDolar: "Dolar Ahorro", montoCompra: dolarData.array[18], montoVenta: dolarData.array[19])
            }
            
            //Dolar Tarjeta
            if dolarVm.isLoading{
                DolarCardLoading()
            } else if dolarVm.error != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarData = dolarVm.dolar {
                CardPrincipal(tipoDolar: "Dolar Tarjeta", montoCompra: dolarData.array[21], montoVenta: dolarData.array[22])
            }
            Button("Scrapear perro") {
                dolarVm.fetchDolar()
            }
        }
        .padding()
       
    }
        
}

#Preview {
    Home()
       
}

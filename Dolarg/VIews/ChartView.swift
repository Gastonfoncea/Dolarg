//
//  ChartView.swift
//  Dolarg
//
//  Created by Gaston Foncea on 04/05/2024.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    @EnvironmentObject var dolarVm: DolarViewModel
    
    var body: some View {
        VStack {
            
            if dolarVm.isLoadingHistorico {
               // Text("Is loading")
                //crear tarjeta con animation para reflejar la carga de datos
            } else if dolarVm.errorH != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarHistoricoData = dolarVm.historicoDolar {
                Chart {
//                    ForEach(dolarHistoricoData) {data in
//                       
//                        
//                    }
                    
                }

            }
        }
        .onAppear {
            dolarVm.fetchHistorico()
        }
    }
}

#Preview {
    ChartView()
        .environmentObject(DolarViewModel())
}

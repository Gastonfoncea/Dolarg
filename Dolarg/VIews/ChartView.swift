//
//  ChartView.swift
//  Dolarg
//
//  Created by Gaston Foncea on 04/05/2024.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    @StateObject var genfunc = GeneralFunctions()
    @EnvironmentObject var dolarVm: DolarViewModel
    
    var body: some View {
        VStack {
            
            if dolarVm.isLoadingHistorico {
                    ChartLoading()
            } else if dolarVm.errorH != nil {
                ContentUnavailableView("Error en la red", systemImage: "network.slash")
            } else if let dolarHistoricoData = dolarVm.historicoDolar {
    
                let data = [
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[6]) , monto:Int("\(dolarHistoricoData.arrayMontos[6])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[5]) , monto:Int("\(dolarHistoricoData.arrayMontos[5])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[4]) , monto:Int("\(dolarHistoricoData.arrayMontos[4])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[3]) , monto:Int("\(dolarHistoricoData.arrayMontos[3])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[2]) , monto:Int("\(dolarHistoricoData.arrayMontos[2])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[1]) , monto:Int("\(dolarHistoricoData.arrayMontos[1])")!),
                    DolarChartModel(fecha: genfunc.formaterTimeChart(fecha: dolarHistoricoData.arrayFechas[0]) , monto:Int("\(dolarHistoricoData.arrayMontos[0])")!),
                ]
                
                VStack{
                    HStack{
                        Text("Ultimas Cotizaciones")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.colorText2)
                        Spacer()
                    }
                    .padding(.bottom)
                    Chart {
                        ForEach(data) { d in
                            BarMark(x: PlottableValue.value("Dias", d.fecha), y: .value("Precios", d.monto)
                            )
                                .annotation {
                                    Text(String(d.monto))
                                        .font(.caption)
                                }
                                .foregroundStyle(Color.accentColor.opacity(0.8))
                                
                                
                                
                        }
                    }
                }
                .frame(height: 180)
                .padding(.top,-20)
                .chartYAxis(.hidden)
                .chartPlotStyle { plotContent in
                    plotContent
                        .background(Color.clear)
                        
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

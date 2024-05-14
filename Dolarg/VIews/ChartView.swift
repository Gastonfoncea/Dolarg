//
//  ChartView.swift
//  Dolarg
//
//  Created by Gaston Foncea on 04/05/2024.
//

import SwiftUI
import Charts


struct ChartView: View {
    
    var genfunc = GeneralFunctions()
    var dolarVm: DolarViewModel
    @State var showAnimation = true
    
    private let gradientColors = [
        Color.white,
        Color.accentColor.opacity(0.5),
        Color.white.opacity(0.4),
        Color.white.opacity(0.5),
        Color.white.opacity(0.1),
        Color.white.opacity(0.1),
    ]
    
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
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Material.ultraThin)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(LinearGradient(colors: gradientColors, startPoint: .topTrailing, endPoint: .bottomLeading))
                            }
                            
                        VStack {
                            HStack{
                                Text("Ultimas cotizaciones blue")
                                    .font(.footnote)
                                    .fontWeight(.regular)
                                    .foregroundStyle(.white)
                                Spacer()
                            }
                            .padding(.leading,20)
                            Chart {
                                ForEach(data) { d in
                                    BarMark(x: PlottableValue.value("Dias", d.fecha), y: .value("Precios", d.monto))
                                        .annotation {
                                            Text(String(genfunc.separadorDeMil(num: d.monto)))
                                                .font(.caption)
                                                .foregroundStyle(Color.colorText1)
                                        }
                                        .foregroundStyle(Color.accentColor.gradient)
                                }
                            }
                            .frame(height: 150)
                            .frame(maxWidth:.infinity)
                            .padding(.horizontal)
                            .chartXAxis {AxisMarks(values: .automatic) {
                                AxisValueLabel()
                                    .foregroundStyle(Color.colorText1)// <= change the style of the label
                            }
                            }
                            
                            .chartYAxis(.hidden)
                            .chartPlotStyle { plotContent in
                                plotContent
                                    .foregroundStyle(Color.colorText1)
                                
                        }
                        }
                        if showAnimation {
                            ChartAnimationStroke(tipo: .chart)
                        }
                    }
                    .onAppear {
                        withAnimation(.smooth) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                showAnimation = false
                            }
                        }
                       
                    }
                
                }
            }
            
        }
        .frame(height: 210)
        .frame(maxWidth:.infinity)

    }
}

#Preview {
    ChartView(dolarVm: DolarViewModel())
}

//
//  CardPrincipal.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

struct CardPrincipal: View {
    
    @StateObject var genFunc = GeneralFunctions()
    var tipoDolar: String
    @State var montoCompra: Any
    @State var montoVenta: Any
    @State var horaActualizacion: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.clear)
                .background {
                    LinearGradient(colors: [Color.white,Color.accentColor.opacity(0.2)], startPoint: .leading, endPoint: .trailing)
                }
            
            HStack{
                VStack(alignment: .leading,spacing: 5){
                   
                    Text("\(tipoDolar.capitalized)")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.colorText2)
                    Text("Ult Vez \(genFunc.DateTimeActualizado(time: horaActualizacion)) hs")
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor)
                        
//                    Text("03/05 - 17:11")
//                        .font(.footnote)
                }
                Spacer()
                
                HStack{
                    Spacer()
                    VStack(alignment:.leading,spacing: 5){
                      
                        Text("Compra")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.colorText1)
                        
                        Text("\(montoCompra)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.colorText2)
                        
                       

                    }
                    Spacer()
                    VStack(alignment:.leading, spacing:5){
                  
                        Text("Venta")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.colorText1)
                        
                        Text("\(montoVenta)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.colorText2)
                        
                         
                    }
                    Spacer()
                    
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .clipShape(RoundedRectangle(cornerRadius: 8))

    }
}

#Preview {
    CardPrincipal(tipoDolar: "blue",montoCompra: 930, montoVenta: 940, horaActualizacion: "hora actualizada")
}

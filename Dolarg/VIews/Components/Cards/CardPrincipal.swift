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
    var montoCompra: Any
    var montoVenta: Any
    var horaActualizacion: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.colorTarjetas)
            
            HStack{
                VStack(alignment: .leading,spacing: 15){
                   
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
                    VStack(alignment:.leading,spacing: 15){
                      
                        
                        Text("\(montoCompra)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.colorText2)
                        
                        Text("Compra")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.colorText1)

                    }
                    Spacer()
                    VStack(alignment:.leading, spacing:15){
                  
                        Text("\(montoVenta)")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.colorText2)
                        
                        Text("Venta")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.colorText1)
                 
                        
                         
                    }
                    Spacer()
                    
                }
            }
            .padding(.leading)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 85)

    }
}

#Preview {
    CardPrincipal(tipoDolar: "blue",montoCompra: 930, montoVenta: 940, horaActualizacion: "hora actualizada")
}

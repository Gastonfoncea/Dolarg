//
//  CardPrincipal.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

struct CardPrincipal: View {
    
   // @StateObject var genFunc = GeneralFunctions()
    var tipoDolar: String
    var spread: Int
    var actualizacion: String
    var montoCompra: Decimal
    var montoVenta: Decimal
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(Color.colorTarjetas)
            
            HStack{
                ZStack{
                    Circle()
                        .frame(height: 40)
                }
                .padding(.trailing)
                
                
                VStack(alignment: .leading,spacing: 10){
                    //dolar blue
                    Text("Dolar \(tipoDolar.capitalized)")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.colorText1)
                    Text("Spread $ \(montoVenta - montoCompra)")
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor)
                        
//                    Text(genFunc.formatedDate(date: actualizacion))
//                        .font(.footnote)
                }
                Spacer()
                
                HStack{
                    Spacer()
                    VStack(alignment:.leading,spacing: 10){
                      
                        
                        Text("$ \(montoCompra)")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.colorText2)
                        
                        Text("Compra")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundStyle(Color.colorText1)

                    }
                    Spacer()
                    VStack(alignment:.leading, spacing:10){
                  
                        Text("$ \(montoVenta)")
                            .font(.headline)
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
    CardPrincipal(tipoDolar: "blue", spread: 20, actualizacion: "2024-03-28T10:54:00.000Z", montoCompra: 930, montoVenta: 940)
}

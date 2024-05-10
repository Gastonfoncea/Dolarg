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
    private let gradientColors = [
        Color.white,
        Color.white.opacity(0.1),
        Color.white.opacity(0.1),
        Color.white.opacity(0.4),
        Color.white.opacity(0.5),
        Color.accentColor.opacity(0.5)
    ]
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Material.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(LinearGradient(colors: gradientColors, startPoint: .topTrailing, endPoint: .bottomLeading))
                }
            
            HStack{
                VStack(alignment: .leading,spacing: 5){
                   
                    Text("\(tipoDolar.capitalized)")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.white)
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
                            .foregroundStyle(Color.white)
                        
                       

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
                            .foregroundStyle(Color.white)
                        
                         
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


// .fill(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))

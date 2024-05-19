//
//  CardPrincipal.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

struct CardPrincipal: View {
    
    var tipoDolar: String
    @State var montoCompra: String
    @State var montoVenta: String
    @State var horaActualizacion: String
    private let gradientColors = [
        Color.white.opacity(0.8),
        Color.accentColor.opacity(0.5),
        Color.white.opacity(0.4),
        Color.white.opacity(0.5),
        Color.white.opacity(0.1),
        Color.white.opacity(0.1),
    ]
    
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Material.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(LinearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom))
                }
            
            HStack {
                VStack(alignment:.leading,spacing: 5){
                   
                    Text("\(tipoDolar.capitalized)")
                        .font(.headline)
                        .bold()
                        .foregroundStyle(Color.white)

                    Text("Ult Vez \(horaActualizacion.DateTimeActualizado()) hs")
                        .font(.footnote)
                        .foregroundStyle(Color.accentColor)

                }
                .frame(width: 125,alignment: .leading)
                Spacer()
                
                HStack{
                   // Spacer()
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
    
    CardPrincipal(tipoDolar: "blue",montoCompra: "930", montoVenta: "940", horaActualizacion: "hora actualizada")
}


// .fill(LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing))

//
//  ChartAnimationStroke.swift
//  Dolarg
//
//  Created by Gaston Foncea on 11/05/2024.
//

import SwiftUI


//Enumeramos los casos en que la utilizariamos especificando su height para llamarla desde cualquier lado
enum TipoAnimation: CGFloat{
    case chart = 210
    case card = 70
}

struct ChartAnimationStroke: View {
    
    @State var rotation: CGFloat = 0.0
    var tipo : TipoAnimation
    var gradientRainbow = [Color.red,Color.orange,Color.green,Color.blue,Color.purple,Color.pink]
    var gradientAccent = [Color.accentColor,Color.blue,Color.red,Color.green,Color.yellow]
    var lemonGradient = [Color.limonada,Color.yellowLemon,Color.verdeFluo,Color.amarillioFluo]
    
    var body: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth:.infinity)
                    .frame(height: tipo.rawValue)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: lemonGradient), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask {
                        //rectangulo del stroke
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(lineWidth: 1.4)
                                .frame(maxWidth:.infinity)
                                .frame(height: tipo.rawValue)
                        
                    }
                    .clipped()
                   
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.clear)
        }
        .frame(height: tipo.rawValue)
        .frame(maxWidth: .infinity)
        .clipped()
        .onAppear {
            withAnimation(.spring(duration: 3).repeatForever()) {
                rotation = 180
                }
    }
        
        }
    }


#Preview {
    ChartAnimationStroke(tipo: .card)
}

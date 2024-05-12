//
//  ChartAnimationStroke.swift
//  Dolarg
//
//  Created by Gaston Foncea on 11/05/2024.
//

import SwiftUI

struct ChartAnimationStroke: View {
    @State var rotation: CGFloat = 0.0
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width:200)
                //.frame(width: 100)
                .frame(height: 210)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red,.orange,.yellow,.green,.blue,.purple,.pink]), startPoint: .top, endPoint: .bottom))
                .rotationEffect(.degrees(rotation))
                .mask {
                    //rectangulo del stroke
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .stroke(lineWidth: 1)
                        .frame(width:210,height: 210)

                }
                .clipped()
               
        }
       // .frame(maxWidth: .infinity)
        .frame(height: 210)
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses:true)) {
                rotation = 180
                }
            }
        }
    }


#Preview {
    ChartAnimationStroke()
}

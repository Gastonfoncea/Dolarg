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
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(maxWidth:.infinity)
                    .frame(height: 210)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.red,.orange,.green,.blue,.purple,.pink]), startPoint: .top, endPoint: .bottom))
                    .rotationEffect(.degrees(rotation))
                    .mask {
                        //rectangulo del stroke
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(lineWidth: 1.2)
                            .frame(maxWidth:.infinity)
                            .frame(height: 210)
                    }
                    .clipped()
                   
            }
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.clear)
        }
        .frame(height: 210)
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
    ChartAnimationStroke()
}

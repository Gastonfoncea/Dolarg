//
//  ChartLoading.swift
//  Dolarg
//
//  Created by Gaston Foncea on 07/05/2024.
//

import SwiftUI

struct ChartLoading: View {
    
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    var body: some View {
        ZStack{
            Color.black.opacity(0.9)
                .frame(height: 210)
                .cornerRadius(10)
            
            
            Color.white
                .frame(height: 210)
                .cornerRadius(10)
                .mask(
                    Rectangle()
                        .fill(
                        
                            LinearGradient(gradient: .init(colors: [.clear,Color.black.opacity(0.15),.clear]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center : -center)
                )
                
        }
        .foregroundStyle(.colorTarjetas.opacity(0.5))
        .frame(maxWidth: .infinity)
        .frame(height: 210)
        .onAppear{
            withAnimation(Animation.linear.speed(0.35).delay(0)
                .repeatForever(autoreverses: false)){
                    self.show.toggle()
                }
        }

    }

    }

#Preview {
    ChartLoading()
}

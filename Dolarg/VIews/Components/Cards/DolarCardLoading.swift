//
//  DolarCardLoading.swift
//  Dolarg
//
//  Created by Gaston Foncea on 03/05/2024.
//

import SwiftUI

struct DolarCardLoading: View {
    
    @State var show = false
    var center = (UIScreen.main.bounds.width / 2) + 110
    
    var body: some View {
        ZStack{
            Color.colorTarjetas
                .frame(height: 70)
                .cornerRadius(10)
            
            
            Color.white
                .frame(height: 70)
                .cornerRadius(10)
                .mask(
                    Rectangle()
                        .fill(
                        
                            LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.55),.clear]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(.init(degrees: 70))
                        .offset(x: self.show ? center : -center)
                )
                
        }
        .foregroundStyle(.colorTarjetas)
        .frame(maxWidth: .infinity)
        .frame(height: 70)
        .onAppear{
            withAnimation(Animation.linear.speed(0.25).delay(0)
                .repeatForever(autoreverses: false)){
                    self.show.toggle()
                }
        }

    }
}

#Preview {
    DolarCardLoading()
}

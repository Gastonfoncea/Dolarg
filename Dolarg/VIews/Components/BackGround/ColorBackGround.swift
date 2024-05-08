//
//  ColorBackGround.swift
//  Dolarg
//
//  Created by Gaston Foncea on 08/05/2024.
//

import SwiftUI

struct ColorBackGround: View {
    
    @State var animateGradient: Bool = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 0)
            .foregroundStyle(.clear)
            .background {
                LinearGradient(colors: [Color.black,Color.accentColor], startPoint: .topLeading, endPoint: .leading)
                    .hueRotation(.degrees(animateGradient ? 20 : 0))
                    .onAppear{
                        withAnimation(.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            animateGradient.toggle()
                        }
                    }
            }
            .ignoresSafeArea()
    }
}

#Preview {
    ColorBackGround()
}

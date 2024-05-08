//
//  WhiteCardBackGround.swift
//  Dolarg
//
//  Created by Gaston Foncea on 08/05/2024.
//

import SwiftUI

struct WhiteCardBackGround: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.white)
            .ignoresSafeArea(.all)
            .frame(height: 620)

    }
}

#Preview {
    WhiteCardBackGround()
}

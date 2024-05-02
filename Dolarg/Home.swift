//
//  Home.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI
import SwiftSoup

struct Home: View {
    
    @EnvironmentObject var scraper : Scrapper
    
    var body: some View {
        VStack(spacing:20) {
            
            Text("monto compra blue \(scraper.montoCompraBlue)")
            Text("monto venta blue \(scraper.montVentaBlue)")
            Button("Scrapear perro") {
               
            }
        }
        .padding()
    }
}

#Preview {
    Home()
        .environmentObject(Scrapper())
}

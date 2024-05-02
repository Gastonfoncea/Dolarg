//
//  DolargApp.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

@main
struct DolargApp: App {
    
    @StateObject var scraper = Scrapper()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear {
                    scraper.scrappearDolar()
                } 
        }
        .environmentObject(scraper)
        
    }
}

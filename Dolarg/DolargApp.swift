//
//  DolargApp.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

@main
struct DolargApp: App {
    
   
    @StateObject var dolarVm = DolarViewModel()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear {
                   
                } 
        }
        .environmentObject(dolarVm)
        
        
    }
}

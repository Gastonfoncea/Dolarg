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
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear {
                    dolarVm.fetchDolar()
                    dolarVm.fetchHistorico()
                }
        }
        .environmentObject(dolarVm)
        .onChange(of:scenePhase) {oldPhase, newPhase in //manejamos los casos para que cuando pase de backgrounda primer plano scrapee de vuelta
            switch newPhase {
            case .active:
                dolarVm.fetchDolar()
                dolarVm.fetchHistorico()
            case .background:
                break
            case .inactive:
                break
                
            default:
                break
            }
        }
        
        
    }
}

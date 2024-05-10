//
//  DolargApp.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

@main
struct DolargApp: App {
    
   
    @ObservedObject var dolarVm = DolarViewModel()
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            Home()
                .onAppear {
                    dolarVm.fetchDolar()
                    dolarVm.fetchHistorico()
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                              print("entramos en modo reposo")
                            }
        }
        .environmentObject(dolarVm)
        
    }
}

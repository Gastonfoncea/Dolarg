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
            Home(dolarVm: dolarVm)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                              print("entramos en modo reposo")
                            }
        }
        .environmentObject(dolarVm)
        
    }
}


//@Published private(set) var state: CardStatusViewState
///@MainActor enum HomeViewState: Equatable {
//case loading
//case loaded(HomeViewData)
//}

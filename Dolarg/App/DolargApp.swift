//
//  DolargApp.swift
//  Dolarg
//
//  Created by Gaston Foncea on 01/05/2024.
//

import SwiftUI

@main
struct DolargApp: App {
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            HomeView()
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
//                              print("entramos en modo reposo")
//                            }
        }
    }
}


//@Published private(set) var state: CardStatusViewState
///@MainActor enum HomeViewState: Equatable {
//case loading
//case loaded(HomeViewData)
//}

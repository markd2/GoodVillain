//
//  GoodVillainApp.swift
//  GoodVillain
//
//  Created by markd on 3/13/22.
//

import SwiftUI

@main
struct GoodVillainApp: App {
    init() {
        _ = try! CraftableStore.loadStore()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

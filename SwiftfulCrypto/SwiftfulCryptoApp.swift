//
//  SwiftfulCryptoApp.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/25/25.
//

// Developer Preview Places
/*
 
 */

import SwiftUI

@main
struct SwiftfulCryptoApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(viewModel)
        }
    }
}

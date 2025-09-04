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
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                }
                .environmentObject(viewModel)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
        }
    }
}

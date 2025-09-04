//
//  SettingsView.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/3/25.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.example.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/c/swiftfulthinking")!
    let youtubeCourse = URL(string: "https://www.youtube.com/watch?v=TTYKL6CfbSs&list=PLwvDm4Vfkdphbc3bgy_LpLRQ9DDfFGcFu")!
    let coffeeURL = URL(string: "https://www.buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.swiftful-thinking.com")!
    
    var body: some View {
        NavigationStack {
            List {
                swiftfulThinking
                coingecko
                developer
                application
            }
            .font(.headline)
            .tint(.blue)
            .listStyle(.grouped)
            
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissSheetButton()
                }
            }
        }
    }
}

extension SettingsView {
    private var swiftfulThinking: some View {
        Section(header: Text("Swiftful Thinking")) {
            VStack(alignment: .leading) {
                Image("SwiftfulThinkingIcon")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was made by following a @SwiftfulThinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Swiftful Thinking Youtube Channel 🥳", destination: youtubeURL)
            Link("Watch the Course 🎥", destination: youtubeCourse)
            Link("Support Swiftful Thinking ☕️", destination: coffeeURL)
        }
    }
    
    private var coingecko: some View {
        Section(header: Text("Coin Gecko")) {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The cryptocurrency data that used is used in this app comes from Coin Gecko, a free API (the coin prices can be slightly delayed).")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit Coingecko 🥳", destination: coingeckoURL)
        }
    }
    
    private var developer: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Tirzaan Neil, 15yo, in 2025")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit Website 🥳", destination: personalURL)
        }
    }
    
    private var application: some View {
        Section(header: Text("Application")) {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app uses SwiftUI and is written in 100% Swift. The project benefits from multi-threading, publishers/subscribers, and data persistence.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            
            Link("Terms of Service ⚙️", destination: defaultURL)
            Link("Privacy Policy 👤", destination: defaultURL)
            Link("Company Website 🌐", destination: defaultURL)
            Link("Learn More ℹ️", destination: defaultURL)
        }
    }
}

#Preview {
    SettingsView()
}

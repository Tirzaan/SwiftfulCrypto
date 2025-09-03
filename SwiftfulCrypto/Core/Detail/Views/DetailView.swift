//
//  DetailView.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/2/25.
//

import SwiftUI

struct DetailLoadingView: View {
    
    @Binding var coin: CoinModel?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Init DetailView for \(coin.name)")
    }
    
    var body: some View {
        Text("Hello")
    }
}

#Preview {
    DetailView(coin: DeveloperPreview.instance.coin)
}

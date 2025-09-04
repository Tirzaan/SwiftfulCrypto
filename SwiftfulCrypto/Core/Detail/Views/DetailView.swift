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
    
    @StateObject private var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    private let colomns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                ChartView(coin: viewModel.coin)
                    .padding(.vertical)
                VStack(spacing: 20) {
                    overviewTitle
                    Divider()
                    description
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    links
                }
                .padding()
            }
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                navigationBarTrailingItems
            }
        }
    }
}

extension DetailView {
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var description: some View {
        ZStack {
            if let coinDescription = viewModel.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Show Less..." : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }
                    .tint(.blue)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: colomns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.overviewStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: colomns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []) {
                ForEach(viewModel.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
    private var links: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteString = viewModel.websiteURL, let websiteurl = URL(string: websiteString) {
                Link("Website", destination: websiteurl)
            }
            
            if let redditString = viewModel.redditURL, let redditurl = URL(string: redditString) {
                Link("Reddit", destination: redditurl)
            }
        }
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
        .font(.headline)

    }
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.instance.coin)
    }
}

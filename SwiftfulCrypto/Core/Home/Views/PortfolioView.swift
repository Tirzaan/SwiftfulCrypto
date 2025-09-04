//
//  PortfolioView.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/28/25.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInput
                    }
                }
            }
            .background(Color.theme.background.ignoresSafeArea())
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    DismissSheetButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailingTopBarButtons
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 100)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
    }
    
    private var portfolioInput: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrentCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding")
                Spacer()
                TextField("Ex. 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(GetCurrentValue().asCurrentCurrencyWith2Decimals())
            }
        }
        .animation(.easeIn(duration: 0.1), value: selectedCoin?.id)
        .padding()
        .font(.headline)
    }
    
    private var trailingTopBarButtons: some View {
        HStack(spacing: 2) {
            Image(systemName: "checkmark")
                .opacity(showCheckmark ? 1 : 0)
                .font(.subheadline)
            
            Button {
                savePortfolioItem()
            } label: {
                Text("Save".uppercased())
                    .font(.headline)
            }
            .opacity(selectedCoin == nil || quantityText.isEmpty ? 0.5 : 1)
            .disabled(selectedCoin == nil || quantityText.isEmpty ? true : false)
            
        }
    }
    
    private func GetCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0.00
    }
    
    private func savePortfolioItem() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText) else { return }
        
        // save portfolio item
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        }
        
    }
    
    private func removeSelectedCoin() {
        withAnimation(.easeIn) {
            selectedCoin = nil
        }
        viewModel.searchText = ""
        quantityText = ""
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(DeveloperPreview.instance.homeViewModel)
}

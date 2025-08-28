//
//  HomeViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/25/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var stats: [StatisticModel] = [
        StatisticModel(title: "Market Cap", value: "$2.55Tr", percentageChange: 1),
        StatisticModel(title: "24h Volume", value: "$336.68Bn"),
        StatisticModel(title: "BTC Dominance", value: "42.61%"),
        StatisticModel(title: "Portfolio Value", value: "$48,601.95", percentageChange: -7),
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Updates allCoins
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .combineLatest(dataService.$allCoins)
            .map(filterCoins)
            .sink { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
        
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        let lowercasedText = text.lowercased()
        
        return coins.filter({ $0.name.lowercased().contains(lowercasedText) || $0.symbol.lowercased().contains(lowercasedText) || $0.id.lowercased().contains(lowercasedText)})
    }
}

//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/2/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    init(coin: CoinModel) {
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .sink { returnedCoinDetails in
                print("Received new coin details: \(String(describing: returnedCoinDetails))")
            }
            .store(in: &cancellables)
    }
}

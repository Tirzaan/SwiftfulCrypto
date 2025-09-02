//
//  MarketDataService.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/28/25.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var maketData: MarketDataModel? = nil
    
    var maketDataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        maketDataSubscription = NetworkingManager.dowload(url: url)
            .decode(type: GlobleData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobleData) in
                self?.maketData = returnedGlobleData.data
                self?.maketDataSubscription?.cancel()
            })
    }
    
}

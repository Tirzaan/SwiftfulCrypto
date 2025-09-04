//
//  DetailViewModel.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/2/25.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var overviewStatistics: [StatisticModel] = []
    @Published var additionalStatistics: [StatisticModel] = []
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURL: String? = nil

    @Published var coin: CoinModel
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailDataService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        coinDetailService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] returnedArrays in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellables)
        
        coinDetailService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.readableDescription
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURL = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellables)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) {
        return (createOverviewArray(coinModel: coinModel), createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel))
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatisticModel] {
        let pricePercentage = coinModel.currentPrice.asCurrentCurrencyWith6Decimals()
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let pricePercentageStat = StatisticModel(title: "Current Price", value: pricePercentage, percentageChange: pricePercentageChange)
        
        let marketCap = "$\(coinModel.marketCap?.formattedWithAbbreviations() ?? "")"
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatisticModel(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercentageChange)
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatisticModel(title: "Rank", value: rank)
        
        let volume = "$\(coinModel.totalVolume?.formattedWithAbbreviations() ?? "")"
        let volumeStat = StatisticModel(title: "Volume", value: volume)
        
        let overviewArray: [StatisticModel] = [
            pricePercentageStat,
            marketCapStat,
            rankStat,
            volumeStat
        ]
        return overviewArray
    }
    
    private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatisticModel] {
        let high = coinModel.high24H?.asCurrentCurrencyWith6Decimals() ?? "N/A"
        let highStat = StatisticModel(title: "24H High", value: high)
        
        let low = coinModel.low24H?.asCurrentCurrencyWith6Decimals() ?? "N/A"
        let lowStat = StatisticModel(title: "24H Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrentCurrencyWith6Decimals() ?? "N/A"
        let pricePercentageChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatisticModel(title: "24H Price Change ", value: priceChange, percentageChange: pricePercentageChange)
        
        let marketCapChange = "$\(coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")"
        let marketCapPercentageChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatisticModel(title: "24H Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentageChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "N/A" : "\(blockTime)"
        let blockTimeStat = StatisticModel(title: "Block Time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "N/A"
        let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
        
        let additionalArray: [StatisticModel] = [
            highStat,
            lowStat,
            priceChangeStat,
            marketCapChangeStat,
            blockTimeStat,
            hashingStat
        ]
        return additionalArray
    }
}

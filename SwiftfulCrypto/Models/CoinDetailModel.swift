//
//  CoinDetailModel.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/2/25.
//

import Foundation

// JSON Data
/*
 URL: https://api.coingecko.com/api/v3/coins/bitcoin?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false
 */

struct CoinDetailModel: Codable {
    let id: String?
    let symbol: String?
    let name: String?
    let blockTimeInMinutes: Int?
    let hashingAlgorithm: String?
    let description: Description?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case blockTimeInMinutes = "block_time_in_minutes"
        case hashingAlgorithm = "hashing_algorithm"
        case description
        case links
    }
    
    var readableDescription: String {
        return description?.en?.removingHTMLOccurrences ?? "No Description Available"
    }
}

struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
    
    enum CodingKeys: String, CodingKey {
        case homepage
        case subredditURL = "subreddit_url"
    }
}

struct Description: Codable {
    let en: String?
}

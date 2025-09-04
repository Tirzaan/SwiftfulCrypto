//
//  Date.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/3/25.
//

import Foundation

extension Date {
    
    
    init(coinGeckoString: String) {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formater.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    func asShortString() -> String {
        return shortFormatter.string(from: self)
    }
    
}

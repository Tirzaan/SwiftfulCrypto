//
//  Double.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/25/25.
//

import Foundation

extension Double {
    
    /// Converts a Double into a currency with 2 decimal places
    /// ```
    /// Convert 1234 to $1,234.00
    /// Convert 1234.567 to $1,234.56
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current
//        formater.currencyCode = "usd"
//        formater.currencySymbol = "$"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 2
        return formater
    }
    
    /// Converts a Double into a currency as a String with 2 decimal places
    /// ```
    /// Convert 1234 to "$1,234.00"
    /// Convert 1234.567 to "$1,234.56"
    /// ```
    func asCurrentCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a currency with 2 to 6 decimal places
    /// ```
    /// Convert 1234.56 to $1,234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    /// Convert 0.1234567 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formater = NumberFormatter()
        formater.usesGroupingSeparator = true
        formater.numberStyle = .currency
//        formater.locale = .current
//        formater.currencyCode = "usd"
//        formater.currencySymbol = "$"
        formater.minimumFractionDigits = 2
        formater.maximumFractionDigits = 6
        return formater
    }
    
    /// Converts a Double into a currency as a String with 2 to 6 decimal places
    /// ```
    /// Convert 1234.56 to "$1,234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    /// Convert 0.1234567 to "$0.123456"
    /// ```
    func asCurrentCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Converts a Double into a String representation
    /// ```
    /// Convert 1.2345 to "1.23"
    /// ```
    func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Converts a Double into a String representation with percent symbol
    /// ```
    /// Convert 1.2345 to "1.23%"
    /// ```
    func asPercentString() -> String {
        return asNumberString() + "%"
    }
    
}

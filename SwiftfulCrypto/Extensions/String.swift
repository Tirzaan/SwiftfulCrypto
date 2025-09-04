//
//  String.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/3/25.
//

import Foundation

extension String {
    var removingHTMLOccurrences: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}

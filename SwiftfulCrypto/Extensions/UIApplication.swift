//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/26/25.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

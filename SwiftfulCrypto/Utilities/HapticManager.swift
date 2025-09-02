//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 9/1/25.
//

import Foundation
import SwiftUI

class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

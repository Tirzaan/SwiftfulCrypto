//
//  Color.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/25/25.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme2()
    static let launch = LaunchTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}

struct ColorTheme2 {
    let accent = Color.purple
    let background = Color.white
    let green = Color.green
    let red = Color.red
    let secondaryText = Color.gray
}

struct LaunchTheme {
    let background = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
}

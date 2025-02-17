//
//  AppearanceOption.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

enum AppearanceOption: Int, CaseIterable {
    case system
    case light
    case dark
    case darkWithOrangeAccent
}

extension AppearanceOption {
    var name: String {
        switch self {
        case .system: return "System"
        case .light: return "Light"
        case .dark: return "Dark"
        case .darkWithOrangeAccent: return "Dark with orange"
        }
    }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        case .darkWithOrangeAccent: return .dark
        }
    }

    var accentColor: Color {
        switch self {
        case .darkWithOrangeAccent: return .orange
        default: return .brandAccent
        }
    }
}

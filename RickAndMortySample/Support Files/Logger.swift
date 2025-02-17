//
//  Logger.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 16/2/2025.
//

import Foundation
import OSLog

extension Logger {
    // swiftlint:disable:next line_length
    static let app = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.example.RickAndMortySample", category: "RickAndMortySample")
}

struct Log {
    static func debug(_ str: String) {
        self.log(level: .debug, message: str)
    }

    static func info(_ str: String) {
        self.log(level: .info, message: str)
    }

    static func error(_ str: String) {
        // Analytic event can be added here if needed
        self.log(level: .error, message: str)
    }

    static private func log(level: OSLogType, message: String) {
        #if DEBUG
        Logger.app.log(level: level, "\(message)")
        #endif
    }
}

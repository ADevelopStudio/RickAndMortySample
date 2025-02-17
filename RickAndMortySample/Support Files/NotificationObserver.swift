//
//  NotificationObserver.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI
final class NotificationObserver: ObservableObject {
    static let shared = NotificationObserver()

    @Published var deepLink: ApiPath?
}

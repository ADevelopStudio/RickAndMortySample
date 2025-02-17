//
//  PushNotificationsViewModel.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

@MainActor
final class PushNotificationsViewModel: ObservableObject {
    enum PushStatus {
        case checking
        case allowed
        case notAllowed
    }

    @Published var pushStatus: PushStatus = .checking
    @Published var openSettingsAlert = false

    var isBundleIdValid: Bool {
        Bundle.main.bundleIdentifier == "au.com.makemeapp.RickAndMortySample"
    }

    func checkStatus() async {
        let status = await UNUserNotificationCenter.current().notificationSettings().authorizationStatus
        pushStatus = status == .authorized ?.allowed : .notAllowed
    }

    func actionOnCTA() async {
        switch await UNUserNotificationCenter.current().notificationSettings().authorizationStatus {
        case .authorized:
            pushStatus = .allowed
        case .notDetermined:
            do {
                // swiftlint:disable:next line_length
                let success = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
                if success {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            } catch {
                self.openSettingsAlert = true
            }
        default:
            self.openSettingsAlert = true
        }
    }
}

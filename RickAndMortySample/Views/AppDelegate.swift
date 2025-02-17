//
//  AppDelegate.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import UIKit
import NotificationCenter

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    private(set) static var shared = AppDelegate()

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        AppDelegate.shared = self
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        Log.info("didReceive notification")
        Log.info(response.notification.request.content.title)
        if let urlString = response.notification.request.content.userInfo["link_url"] as? String,
           let apiPath = ApiPath(pathString: urlString) {
            NotificationObserver.shared.deepLink = apiPath
        }
    }

    // swiftlint:disable:next line_length
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .badge, .sound])
    }
}

//
//  PushNotificationsView.swift
//  RickAndMortySample
//
//  Created by Dmitrii Zverev on 17/2/2025.
//

import SwiftUI

struct PushNotificationsView: View {
    @StateObject private var viewModel = PushNotificationsViewModel()
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        VStack(spacing: 20) {
            switch viewModel.pushStatus {
            case .allowed:
                if #available(iOS 18.0, *) {
                    bellIcon
                        .symbolEffect(.wiggle, options: .repeat(.continuous))
                } else if #available(iOS 17.0, *) {
                    bellIcon
                        .symbolEffect(.variableColor, isActive: true)
                } else {
                    bellIcon
                }
                if !viewModel.isBundleIdValid {
                    // swiftlint:disable:next line_length
                    Text("Loks like you changed bundle ID of the project.\nIn order to receive push notifications, make sure to change the content of the apns files as well. Otherwise push would not work")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                        .bold()
                        .foregroundStyle(.red)
                }

                // swiftlint:disable:next line_length
                Text("Now please drag and drop one of the provided in the repository JSON files ('New Episode.apns' or 'Explore the character.apns') into the simulator to test push notifications.\n\nApplication can be active or in background. Doesn't matter.")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                Spacer()
            case .checking:
                ProgressView()
            case .notAllowed:
                Text("Need to allow push notifications first")
                    .font(.title3)
                Button("Allow") {
                    Task { await viewModel.actionOnCTA() }
                }
            }
        }
        .padding()
        .animation(.easeInOut, value: viewModel.pushStatus)
        .navigationTitle("Notifications")
        .task {
            await viewModel.checkStatus()
        }
        .onChange(of: scenePhase) {
            switch $0 {
            case .active:
                Task { await viewModel.checkStatus() }
            default: break
            }
        }
        .alert("Need to allow push notifications", isPresented: $viewModel.openSettingsAlert, actions: {
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                Button("Open settings") {
                    UIApplication.shared.open(url)
                }
            }
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("Please open the phone settings and allow push notifications")
        })
    }

    private var bellIcon: some View {
        Image(systemName: "bell.and.waves.left.and.right")
            .resizable()
            .scaledToFit()
            .foregroundStyle(.primary, .accent)
            .frame(height: 100)
            .padding(.top, 40)
    }
}

#Preview {
    NavigationStack {
        PushNotificationsView()
    }
}

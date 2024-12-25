//
//  cpqr_merchant_demoApp.swift
//  cpqr_merchant_demo
//
//  Created by Macbook on 07/08/2024.
//

import SwiftUI

@main
struct cpqr_merchant_demoApp: App {
    @StateObject var mainVM = MainViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if (mainVM.isUserLogin) {
                    MainTabView()
                } else {
                    WelcomeView()
//                    ScannerView()
                }
            }
        }
    }
}

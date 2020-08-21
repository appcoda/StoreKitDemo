//
//  StoreKitLocalDemoApp.swift
//  StoreKitLocalDemo
//
//  Created by Gabriel Theodoropoulos.
//

import SwiftUI

@main
struct StoreKitLocalDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RecipesView()
        }
    }
}


class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        IAPManager.shared.startObserving()
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        IAPManager.shared.stopObserving()
    }
}

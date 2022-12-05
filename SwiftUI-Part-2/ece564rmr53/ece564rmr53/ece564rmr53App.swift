//
//  ece564rmr53App.swift
//  ece564rmr53
//
//  Created by Rashaad Ratliff-Brown on 10/1/22.
//

import SwiftUI

@main
struct ece564rmr53App: App {
    @StateObject private var manager = DataManager.shared
    let persistentStorage = CoreDataManager.shared
    //@StateObject private var json = JSONViewModel.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext,
                                    persistentStorage.container.viewContext)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure your library here
        
        return true
    }
}

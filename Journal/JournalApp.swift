//
//  JournalApp.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//
// Main entry point of the application and manages the app's tab navigation.
import SwiftUI
import SwiftData

@main
struct JournalApp: App {
    
    var body: some Scene {
        WindowGroup {
            TabView {
                
                NavigationStack {
                    EntryListView()
                }
                .tabItem {
                    Label("All", systemImage: "book")
                }
                
                NavigationStack {
                    FavoriteEntriesView()
                }
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        .modelContainer(for: JournalEntry.self)
    }
}


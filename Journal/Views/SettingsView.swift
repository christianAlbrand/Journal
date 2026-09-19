//
//  SettingsView.swift
//  Journal
//
//  Created by Christian-SDGKU on 18/09/26.
//
// Provides application settings using @AppStorage for persistent user preferences.

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("username") private var username = ""
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("showFavoritesFirst") private var showFavoritesFirst = false
    
    var body: some View {
        Form {
            Section("Profile") {
                TextField("Username", text: $username)
            }
            
            Section("Appearance") {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }
            
            Section("Journal") {
                Toggle(
                    "Show Favorites First",
                    isOn: $showFavoritesFirst
                )
            }
        }
        .navigationTitle("Settings")
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}

//
//  JournalApp.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//

import SwiftUI
import SwiftData

@main
struct JournalApp: App {
// 1.- SAFER
//    var modelContainer:ModelContainer = {
//        do {
//            return try ModelContainer(for:JournalEntry.self)
//        }catch {
//            fatalError("Error loading container...")
//        }
//    }()
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                EntryListView()
            }
        }.modelContainer(for:JournalEntry.self)
    }
}

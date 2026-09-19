//
//  FavoriteEntriesView.swift
//  Journal
//
//  Created by Christian-SDGKU on 18/09/26.
//
// Displays journal entries that have been marked as favorites.

import SwiftUI
import SwiftData

struct FavoriteEntriesView: View {
    
    @State private var searchText = ""
    
    @Query(
        filter: #Predicate<JournalEntry> { entry in
            entry.isFavorite
        },
        sort: \JournalEntry.date,
        order: .reverse
    )
    private var entries: [JournalEntry]
    
    var filteredEntries: [JournalEntry] {
        if searchText.isEmpty {
            return entries
        }
        
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.body.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        List {
            
            if filteredEntries.isEmpty {
                ContentUnavailableView(
                    "No favorite entries",
                    systemImage: "star"
                )
            } else {
                ForEach(filteredEntries) { entry in
                    NavigationLink {
                        EntryDetailView(entry: entry)
                    } label: {
                        EntryRow(entry: entry)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .searchable(
            text: $searchText,
            prompt: "Search favorites"
        )
    }
}

#Preview {
    NavigationStack {
        FavoriteEntriesView()
    }
}

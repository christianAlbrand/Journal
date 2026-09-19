//
//  EntryListView.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//

//  Displays journal entries, allows searching, sorting, and deleting entries.


import SwiftUI
import SwiftData

struct EntryListView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var searchText = ""
    
    // Entries are sorted from newest to oldest using @Query.
    @Query(
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
                    "No entries",
                    systemImage: "book.closed"
                )
            } else {
                ForEach(filteredEntries) { entry in
                    
                    NavigationLink {
                        EntryDetailView(entry: entry)
                    } label: {
                        EntryRow(entry: entry)
                    }
                }
                .onDelete(perform: deleteRow)
            }
        }
        .navigationTitle("Journal")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    EntryFormView(entry: nil)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .searchable(
            text: $searchText,
            prompt: "Search title or content"
        )
    }
    
    private func deleteRow(at offsets: IndexSet) {
        for index in offsets {
            context.delete(filteredEntries[index])
        }
        
        try? context.save()
    }
}

struct EntryRow: View {
    
    var entry: JournalEntry
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            HStack {
                Text(entry.title)
                    .font(.headline)
                    .lineLimit(1)
                
                Spacer()
                
                if entry.isFavorite {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                }
            }
            
            Text(entry.body)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(2)
            
            Text(
                entry.date.formatted(
                    date: .abbreviated,
                    time: .shortened
                )
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
    }
}

#Preview {
    EntryRow(
        entry: JournalEntry(
            title: "Hello",
            body: "World",
            isFavorite: true
        )
    )
}

//
//  EntryListView.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//

import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) private var context
    @State var searchText: String = ""
    // called your query
    @Query(sort: \JournalEntry.date) private var entries: [JournalEntry]

    var filteredEntries: [JournalEntry] {
        if searchText.isEmpty {
            return entries
        }
        
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        List{
            if entries.isEmpty {
                ContentUnavailableView("No entries", systemImage: "book.closed")
            }else {
                ForEach(filteredEntries) { entry in
                    NavigationLink{
                        EntryDetailView(entry: entry)
                    } label:{
                        EntryRow(entry: entry)
                    }
                }.onDelete(perform: deleteRow)
            }
        }.toolbar {
            ToolbarItem(placement: .topBarTrailing){
                NavigationLink{
                    EntryFormView(entry: nil)
                } label: {
                    Image(systemName: "plus")
                }
            }
        }.searchable(text: $searchText)
    }

    func deleteRow(at offsets: IndexSet){
        for index in offsets {
            context.delete(entries[index])
        }
    }
}

struct EntryRow: View {
    var entry: JournalEntry
    var body: some View {
        HStack {
            VStack{
                HStack{
                    Text(entry.title).lineLimit(1)
                    Text(entry.date.formatted())
                    if entry.isFavorite {
                        Image(systemName: "star.fill")
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    EntryRow(entry: JournalEntry(title: "Hello", body: "World", isFavorite: true))
}

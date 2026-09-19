//
//  EntryListViewModel.swift
//  Journal
//
//  Created by Christian-SDGKU on 18/09/26.
//
// Handles the logic related to searching and managing journal entries.

import Foundation
import SwiftData

class EntryListViewModel {

    // Searches entries by title or body.
    func searchEntries(
        entries: [JournalEntry],
        searchText: String
    ) -> [JournalEntry] {
        
        if searchText.isEmpty {
            return entries
        }
        
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.body.localizedCaseInsensitiveContains(searchText)
        }
    }

    // Deletes an entry from SwiftData.
    func deleteEntry(
        entry: JournalEntry,
        context: ModelContext
    ) {
        context.delete(entry)
    }
}

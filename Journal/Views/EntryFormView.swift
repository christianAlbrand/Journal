//
//  EntryFormView.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//
// Provides a form to create and edit journal entries.
import SwiftUI
import SwiftData

struct EntryFormView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let entry: JournalEntry?
    
    @State private var title = ""
    @State private var entryBody = ""
    @State private var isFavorite = false
    
    var body: some View {
        Form {
            
            Section("Title") {
                TextField(
                    "Enter title...",
                    text: $title
                )
            }
            
            Section("Body") {
                TextEditor(text: $entryBody)
                    .frame(height: 220)
            }
            
            Section("Favorite") {
                Toggle(
                    "Mark as favorite",
                    isOn: $isFavorite
                )
            }
        }
        .navigationTitle(
            entry == nil ? "New Entry" : "Edit Entry"
        )
        .toolbar {
            
            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    save()
                }
                .disabled(
                    title
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                        .isEmpty
                )
            }
        }
        .onAppear {
            guard let entry else {
                return
            }
            
            title = entry.title
            entryBody = entry.body
            isFavorite = entry.isFavorite
        }
    }
    
    private func save() {
        let cleanTitle = title.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        let cleanBody = entryBody.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        guard !cleanTitle.isEmpty else {
            return
        }
        
        if let entry {
            entry.title = cleanTitle
            entry.body = cleanBody
            entry.isFavorite = isFavorite
        } else {
            let newEntry = JournalEntry(
                title: cleanTitle,
                body: cleanBody,
                isFavorite: isFavorite
            )
            
            context.insert(newEntry)
        }
        
        do {
            try context.save()
        } catch {
            print("Error saving entry: \(error)")
            return
        }
        
        dismiss()
    }
}

#Preview {
    NavigationStack {
        EntryFormView(entry: nil)
    }
}

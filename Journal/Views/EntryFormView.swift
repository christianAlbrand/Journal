//
//  EntryFormView.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//

import SwiftUI
import SwiftData

struct EntryFormView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    let entry:JournalEntry? // if == nil -> then create a new one
    
    @State var title: String = ""
    @State var entryBody: String = ""
    @State var isFavorite: Bool = false
    var body: some View {
        Form{
            Section("Title"){
                TextField("Enter title...", text:$title)
            }
            
            Section("Body"){
                TextEditor(text: $entryBody)
                    .frame(height: 220)
            }
            
            Section("Favorite"){
                Toggle("Mark as favorite",isOn: $isFavorite)
            }
        }
        .navigationTitle(entry == nil ? "New Entry" : "Edit Entry")
        .toolbar{
            ToolbarItem(placement: .topBarLeading){
                Button("Cancel"){ dismiss()}
            }
            ToolbarItem(placement: .topBarLeading){
                Button("Save"){
                    save()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .onAppear{
            guard let entry else { return }
            
            title = entry.title
            entryBody = entry.body
            isFavorite = entry.isFavorite
        }
    }
    
    private func save(){
        let t = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let b = entryBody.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !t.isEmpty else { return }
        
        if let entry{
            entry.title = t
            entry.body = b
            entry.isFavorite = isFavorite
        }else {
            context.insert(JournalEntry(title: t, body: b, isFavorite: isFavorite))
        }
        dismiss()
    }
}

// Works like a parent view
#Preview {
    NavigationStack {
        EntryFormView(entry: nil)
    }
}

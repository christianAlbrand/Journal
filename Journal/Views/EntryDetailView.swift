//
//  EntryDetailView.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//
// Displays the complete information of a journal entry and provides edit, favorite, and delete actions.

import SwiftUI
import SwiftData

struct EntryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State var showEdit: Bool = false

    let entry: JournalEntry

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Text(entry.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        entry.isFavorite.toggle()
                    } label: {
                        Image(systemName: entry.isFavorite ? "star.fill" : "star")
                            .font(.title2)
                            .foregroundStyle(entry.isFavorite ? .yellow : .secondary)
                            .padding(10)
                            .background(.yellow.opacity(0.12))
                            .clipShape(Circle())
                    }
                }
                
                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Divider()
                
                Text(entry.body)
                    .font(.body)
                    .lineSpacing(6)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    showEdit = true
                }
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button("Delete") {
                    context.delete(entry)
                    dismiss()
                }
                .foregroundStyle(.red)
            }
        }
        .sheet(isPresented: $showEdit) {
            NavigationStack {
                EntryFormView(entry: entry)
            }
        }
    }
}

#Preview {
    NavigationStack {
        EntryDetailView(
            entry: JournalEntry(
                title: "Hello",
                body: "World"
            )
        )
    }
}

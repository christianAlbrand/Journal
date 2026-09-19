//
//  JournalEntry.swift
//  Journal
//
//  Model that represents a journal entry and stores its data using SwiftData.
//


import Foundation
import SwiftData

@Model
class JournalEntry {
    var title: String
    var body: String
    var isFavorite: Bool
    var date: Date
    
    init(
        title: String,
        body: String,
        isFavorite: Bool = false,
        date: Date = .now
    ) {
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
        self.date = date
    }
}

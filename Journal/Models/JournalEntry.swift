//
//  JournalEntry.swift
//  Journal
//
//  Created by Christian-SDGKU on 16/09/26.
//
import Foundation
import SwiftData

@Model
class JournalEntry{
    var title: String
    var body: String
    var isFavorite: Bool
    var date: Date
    
    init(title: String, body: String, isFavorite: Bool = false, date: Date = .now)  {
        self.title = title
        self.body = body
        self.isFavorite = isFavorite
        self.date = date
    }
}

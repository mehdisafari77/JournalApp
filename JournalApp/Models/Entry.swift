//
//  Entry.swift
//  JournalApp
//
//  Created by Mehdi MMS on 17/02/2022.
//

import Foundation

class Entry: Codable {
    let title: String
    let body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title && lhs.body == rhs.body
    }
}

//
//  EntryController.swift
//  JournalApp
//
//  Created by Mehdi MMS on 17/02/2022.
//

import Foundation

class EntryController {
    static let shared = EntryController()  // We only want one instance of this class
    var entries: [Entry] = []   // create empty array that will hold all entries
    
    // CRUD : Create, Read, Update, Delete
    
    //create
    func createEntry(title: String, body: String) {
        // create new instance of an entry with what was passed in
        let newEntry = Entry(title: title, body: body)
        // add the new entry to entries array
        entries.append(newEntry)
        saveToPersistenceStore()
    }
    
    //delete
    func deleteEntry(entry: Entry) {
        // object must be equatable to use .firstIndex(of: ) to find match in array
        guard let index = entries.firstIndex(of: entry) else { return }
        entries.remove(at: index)
        saveToPersistenceStore()
    }
    
    // MARK: Persistence Store
    func persistentStore() -> URL {
        // find available URLs to store data
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Journal.json") // save as .json file
        return fileURL
    }
    
    // 1. Save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(entries) // encode entries and save to data
            try data.write(to: persistentStore())   // write to URL by calling method above
        } catch {
            print("We had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // 2. Load
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: persistentStore())  // get data from persistence store
            let fetchedEntries = try JSONDecoder().decode([Entry].self, from: data)
            entries = fetchedEntries
        } catch {
            print("We had an error loading from our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
}

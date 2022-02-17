//
//  EntryTableViewController.swift
//  JournalApp
//
//  Created by Mehdi MMS on 17/02/2022.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var entryBodyTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EntryController.shared.loadFromPersistenceStore()
    }
    
    @IBAction func addEntryButton(_ sender: Any) {
        // must unwrap using guard statement
        guard let entryTitle = entryTitleTextField.text,
              let entryBody = entryBodyTextField.text,
              // check that both required fields aren't empty
              !entryTitle.isEmpty,
              !entryBody.isEmpty else { return }
        // calls createEntry() method in EntryController file
        EntryController.shared.createEntry(title: entryTitle, body: entryBody)
        entryTitleTextField.text = ""
        entryBodyTextField.text = ""
        tableView.reloadData() // reload table after adding song
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.shared.entries.count //get current count of array
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.body
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // get the row that was swiped
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            //call deleteEntry() method in EntryController file
            EntryController.shared.deleteEntry(entry: entryToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let tappedIndexPath = tableView.indexPathForSelectedRow else { return }
        let entry = EntryController.shared.entries[tappedIndexPath.row]
        if let detailVC = segue.destination as? EntryDetailViewController {
            detailVC.entry = entry
        }
    }
}

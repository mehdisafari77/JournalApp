//
//  EntryDetailViewController.swift
//  JournalApp
//
//  Created by Mehdi MMS on 17/02/2022.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var entryTitleLabel: UILabel!
    @IBOutlet weak var entryBodyLabel: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let entry = entry, isViewLoaded else { return }

        entryBodyLabel.backgroundColor = .clear
        entryTitleLabel.text = entry.title
        entryBodyLabel.text = entry.body
    }

    var entry: Entry? {
        didSet {
            updateViews()
        }
    }
}

//
//  DetailViewController.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/17/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var displayNameLabel: UILabel!
    @IBOutlet var objectTypeLabel: UILabel!
    @IBOutlet var publishedLabel: UILabel!

    var cell:Cell?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(
        title: "Something Else", style: .plain, target: nil, action: nil)
        populateText()

    }
    
    func populateText() {
        titleLabel.text = String(htmlEncodedString: cell?.title ?? "No title found.")
        displayNameLabel.text = String(htmlEncodedString: cell?.actor.displayName ?? "No name found.")
        objectTypeLabel.text = String(htmlEncodedString: cell?.object.objectType ?? "No type found")
        publishedLabel.text = String(dateString: cell?.published ?? "No published date found")
    }
}

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
        populateText()
    }
    
    func populateText() {
        titleLabel.text = cell?.title
        displayNameLabel.text = cell?.actor.displayName
        objectTypeLabel.text = cell?.object.objectType
        publishedLabel.text = formatDateStr(dateString: cell!.published)
    }

    func formatDateStr(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-mm-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy ' at ' hh:mm a"
        let date = dateFormatterGet.date(from: dateString)
        return dateFormatterPrint.string(from: date!)
    }

}

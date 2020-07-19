//
//  CustomTableViewCell.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/17/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"

    @IBOutlet var title: UILabel!
    @IBOutlet var displayName: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
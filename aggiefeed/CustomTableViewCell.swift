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
    @IBOutlet var rectangleContainer: UIView!
    static func nib() -> UINib{
        return UINib(nibName: "CustomTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        
        rectangleContainer.layer.cornerRadius = 7.5
        rectangleContainer.layer.shadowColor = UIColor.darkGray.cgColor
        rectangleContainer.layer.shadowOpacity = 0.25
        rectangleContainer.layer.shadowOffset = .zero
        rectangleContainer.layer.shadowRadius = 7.5
        
        title.numberOfLines = 0
        displayName.numberOfLines = 0
        title.sizeToFit()
        displayName.sizeToFit()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  Helpers.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/18/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//
import Foundation

extension String {
    //For decoding HTML entities
    init?(htmlEncodedString: String) {
        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }
        self.init(attributedString.string)
    }
    
    //For decoding the date published string
    init?(dateString: String){
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "YYYY-mm-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy ' at ' hh:mm a"
        let date = dateFormatterGet.date(from: dateString)
        self.init(dateFormatterPrint.string(from: date!))
    }
}



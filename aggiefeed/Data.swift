//
//  data.swift
//  aggiefeed
//
//  Created by Tyler Jachetta on 7/17/20.
//  Copyright © 2020 Tyler Jachetta. All rights reserved.
//

import Foundation

struct Cell:Decodable {
    var title:String
    var actor:Actor
    var object:Object
    var published:String
}

struct Actor: Decodable {
    var displayName:String
}

struct Object: Decodable {
    var objectType:String
}

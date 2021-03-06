//
//  Store.swift
//  Codes
//
//  Created by Musab Aljarba on 16/09/1442 AH.
//

import Foundation

struct Store: Codable {
    var id: String?
    let name: String
    let picture: String
    let onlinePicture: String
    var codes: [String]?
    let category: [String]
    let timeAscending: Date
}





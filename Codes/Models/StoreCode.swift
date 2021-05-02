//
//  StoreCode.swift
//  Codes
//
//  Created by Musab Aljarba on 18/09/1442 AH.
//

import Foundation

struct StoreCode: Codable {
    var id: String?
    var title: String = ""
    var Description: String = ""
    var votes: Int = 0
}

extension StoreCode {
    
    static func from(_ storeCodeVS: StoreCodesViewState) -> StoreCode {
        return StoreCode(title: storeCodeVS.title, Description: storeCodeVS.Description)
    }
}

enum codeVote {
    case up
    case down
}

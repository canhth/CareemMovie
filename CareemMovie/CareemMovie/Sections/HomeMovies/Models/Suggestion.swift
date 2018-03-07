//
//  Suggestion.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation

// Use Codeable in case when we need to get suggestion from API
final class Suggestion: BaseRealmObjectModel, Codable {
    
    @objc dynamic var id            : Int = 0
    @objc dynamic var name          : String = "0"
    @objc dynamic var totalResult   : String = "0"
    @objc dynamic var created_at    : Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}


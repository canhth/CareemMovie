//
//  Suggestion.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import RealmSwift

// Use Codeable in case when we need to get suggestion from API
final class Suggestion: BaseRealmObjectModel, Codable {
    
    @objc dynamic var id            : Int = 0
    @objc dynamic var name          : String = "0"
    @objc dynamic var totalResult   : String = "0"
    @objc dynamic var created_at    : Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func saveLatestSuggestion() {
        let realm = try! Realm()
        let objects = realm.objects(Suggestion.self)
        
        // Remove last objest
        let duplicatedObject = objects.filter{ $0.name != self.name }
        if objects.count > 10 && duplicatedObject.count == 0 {
            objects.last?.delete()
        }
        let object = self.clone() 
        object.saveToLocal()
    }
    
    class func getListSuggestions() -> [Suggestion] {
        let realm = try! Realm()
        let objects = realm.objects(Suggestion.self).sorted(byKeyPath: "created_at", ascending: false)
        return objects.toArray()
    }
    
    static func createSuggestionObject(name: String, totalResult: String) -> Suggestion {
        let realm = try! Realm()
        let suggestion = Suggestion()
        suggestion.id = (realm.objects(Suggestion.self).max(ofProperty: "id") ?? 0) + 1
        suggestion.name = name
        suggestion.totalResult = totalResult
        suggestion.created_at = Date()
        
        return suggestion
    }
}


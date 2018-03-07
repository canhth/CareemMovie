//
//  ResultExtension.swift
//  iOSSwiftCore
//
//  Created by thcanh on 12/29/16.
//  Copyright © 2016 iOS_Devs. All rights reserved.
//

import Foundation
import RealmSwift

public extension Results {
    
    public func threadSafeObjects<T>() -> [T] {
        var result = [T]()
        for object in self {
            let threadSafeObject = object as! BaseRealmObjectModel
            result.append(threadSafeObject.clone() as! T)
        }
        
        return result
    }
    
    func toArray<T>(type: T.Type) -> [T] {
        return flatMap { $0 as? T }
    }
}


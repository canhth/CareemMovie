//
//  CT_RESTAPI_Utils.swift
//  CT_RESTAPI
//
//  Created by thcanh on 3/2/17.
//  Copyright © 2017 CanhTran. All rights reserved.
//

import Foundation
import RxSwift

public protocol CTArrayType {
    associatedtype Element
}

extension Array: CTArrayType {}

public extension Observable {
    public func continueWithSuccessClosure(block: @escaping (_ element: Element) -> Observable<Element>) -> Observable<Element> {
        return self.flatMapLatest({ (element) -> Observable<Element> in
           
                return block(element)
            
        })
    }
}

public extension String {
    static func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
}

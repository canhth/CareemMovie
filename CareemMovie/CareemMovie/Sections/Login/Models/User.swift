//
//  User.swift
//  ListingRestaurant
//
//  Created by Canh Tran on 2/27/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import UIKit

struct User: Codable {
    
    var token: String
    var firstName: String
    var lastName = ""
    var message = ""
    var email = ""
    var testOptionalVariable : String?
    
    enum UserKeys: String, CodingKey {
        case token
        case firstName = "fname"
        case lastName = "lname"
        case message
        case email
        case testOptionalVariable
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        token = try container.decode(String.self, forKey: .token)
        
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        message = try container.decode(String.self, forKey: .message)
        email = try container.decode(String.self, forKey: .email)
        testOptionalVariable = try container.decodeIfPresent(String.self, forKey: .testOptionalVariable)
        
        
    }
}

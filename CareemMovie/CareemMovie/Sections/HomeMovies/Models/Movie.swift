//
//  Movie.swift
//  CareemMovie
//
//  Created by Tran Hoang Canh on 7/3/18.
//  Copyright © 2018 Tran Hoang Canh. All rights reserved.
//

import Foundation
import ObjectMapper

struct MovieResults: Mappable {
    var page            : Int!
    var totaResults     : Int!
    var totalPages      : Int!
    var results         : [Movie]!

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        page            <- map["page"]
        totaResults     <- map["total_results"]
        totalPages      <- map["total_pages"]
        results         <- map["results"]
    }

}
struct Movie: Mappable {
    var title           : String!
    var posterPath      : String!
    var overview        : String!
    var releaseDate     : String!

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        title               <- map["title"]
        posterPath         <- map["poster_path"]
        overview            <- map["overview"]
        releaseDate        <- map["release_date"]
    }
}

// Type of Poster images
enum ImageSize: String {
    case w92    = "w92"
    case w185   = "w185"
    case w500   = "w500"
    case w780   = "w780"
}


// MARK: Use for Codable Swift 4
//struct MovieResults: Decodable {
//    let page            : Int
//    let total_results   : Int
//    let total_pages     : Int
//    let results         : [Movie]
//}
//
//struct Movie: Decodable {
//    var title           : String
//    var poster_path     : String
//    var overview        : String
//    var release_date    : String
//}

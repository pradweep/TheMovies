//
//  Cast.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit

struct CastResponse: Codable {
    var cast: [Cast]
}

struct Cast: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profile_path: String?
    var profilePhoto: String {
        if let path = profile_path {
            return "https://image.tmdb.org/t/p/original/\(path)"
        } else {
            return "https://picsum.photos/200/300"
        }
    }
}

//
//  Review.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit

struct ReviewResponse: Codable {
    var results: [Review]
}

struct Review: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}

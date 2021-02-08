//
//  MovieURL.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit

enum MovieURL: String {
    case nowPlaying = "now_playing"
    case upcoming   = "upcoming"
    case popular    = "popular"
    
    var urlString: String {
        return "\(MovieDownloadManager.baseURL)\(self.rawValue)?api_key=\(API.key)&language=en-US&page=1"
    }
 }

//
//  MovieDownloadManager.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit
import SwiftUI

final class MovieDownloadManager: ObservableObject {
    
    @Published var movies = [Movie]()
    @Published var cast  = [Cast]()
    
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    func getnowPlaing() {
        self.getMovies(fromUrl: .nowPlaying)
    }
    
    func getUpComing() {
        self.getMovies(fromUrl: .upcoming)
    }
    
    func getPopular() {
        self.getMovies(fromUrl: .popular)
    }
    
    func getCast(from movie: Movie) {
        let baseURL = "\(Self.baseURL)\(movie.id ?? 100)/credits?api_key=\(API.key)&language=en-US"
        NetworkManager<CastResponse>.fetch(from: baseURL) { (result) in
            switch result {
            case .success(let response):
                self.cast = response.cast
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func getMovies(fromUrl: MovieURL) {
        NetworkManager<MovieResponse>.fetch(from: fromUrl.urlString) { (result) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}

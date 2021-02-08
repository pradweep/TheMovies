//
//  MovieReviewManager.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit

final class MovieReviewManager: ObservableObject {
    
    @Published var review = [Review]()
    
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieReviews() {
        
    }
    
    private func getReview(for movie: Movie) {
        let baseURL = "\(Self.baseURL)\(movie.id ?? 100)/reviews?api_key=\(API.key)"
        NetworkManager<ReviewResponse>.fetch(from: baseURL) { (result) in
            switch result {
            case .success(let response):
                self.review = response.results
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

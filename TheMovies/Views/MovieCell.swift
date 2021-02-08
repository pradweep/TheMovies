//
//  MovieCell.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 08/02/21.
//

import SwiftUI

struct MovieCell: View {
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            posterImage
            VStack(alignment: .leading, spacing: 0) {
                Text(movie.titleWithLanguage)
                    .font(.system(size: 15))
                    .bold()
                    .foregroundColor(Color.blue)
                HStack {
                    ZStack {
                        Circle()
                            .trim(from: 0, to: CGFloat(movie.voteAverage))
                            .stroke(Color.orange, lineWidth: 4)
                            .frame(width: 50)
                            .rotationEffect(.init(degrees: -90))
                        Circle()
                            .trim(from: 0, to: 1)
                            .stroke(Color.orange, lineWidth: 4).opacity(0.2)
                            .frame(width: 50)
                            .rotationEffect(.init(degrees: -90))
                        Text(String(format: "%.2f", movie.vote_average ?? 0.0))
                            .font(.subheadline)
                            .foregroundColor(Color.orange)
                    }
                    
                    Text(movie.release_date ?? "")
                        .foregroundColor(Color.black)
                        .font(.subheadline)
                }.frame(height: 80)
                
                Text(movie.overview ?? "")
                    .font(.body)
                    .foregroundColor(Color.gray)
            }
        }
    }
    
    //MARK: - Private Views
    
    private var posterImage: some View {
        AsyncImage(url: URL(string:movie.posterPath)!) {
            Rectangle().foregroundColor(Color.gray).opacity(0.4)
        } image: { (img) -> Image in
            Image(uiImage: img)
                .resizable()
        }
        .frame(width: 100, height: 160)
        .animation(.easeInOut(duration: 0.5))
        .transition(.opacity)
        .scaledToFill()
        .cornerRadius(15)
        .shadow(radius: 15)
    }
    
}

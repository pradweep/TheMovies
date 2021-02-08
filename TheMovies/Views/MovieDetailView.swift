//
//  MovieDetailView.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 08/02/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var imageLoader: ImageLoader
    
    private var movie: Movie
    
    @ObservedObject private var movieManager = MovieDownloadManager()
    
    init(movie: Movie) {
        self.movie = movie
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: URL(string: movie.posterPath)!, imageCache: Environment.init(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            backgroundView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    headerView
                    moviePoster
                    movieOverview
                    reviewsLink
                    castInfo
                }.padding(.top, 84)
                .padding(.horizontal, 32)
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
    private var backgroundView: some View {
        imageView.onAppear(perform: imageLoader.load)
            .blur(radius: 100)
    }
    
    private var imageView: some View {
        Group {
            if(imageLoader.image != nil) {
                    Image(uiImage: imageLoader.image!)
                        .resizable()
            } else {
                Rectangle().foregroundColor(Color.gray.opacity(0.4))
            }
        }
    }
    
    private var headerView: some View {
        VStack {
            Text(movie.titleWithLanguage)
                .font(.title)
                .bold()
            Text("Release date:\(movie.release_date ?? "")")
                .font(.subheadline)
        }.foregroundColor(.white)
    }
    
    private var moviePoster: some View {
        HStack(alignment: .center) {
            Spacer()
            imageView.frame(width: 200, height: 320)
                .cornerRadius(20)
            Spacer()
        }
    }
    
    private var movieOverview: some View {
        Text(movie.overview ?? "")
            .font(.body)
            .foregroundColor(Color.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewsLink: some View {
        VStack {
            Divider()
            NavigationLink(destination: Text("Some Review")) {
                HStack {
                    Text("Review")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(Color.white)
                    Spacer()
                }
            }
            Divider()
        }
    }
    
    private var castInfo: some View {
        VStack(alignment: .leading) {
            Text("CAST").foregroundColor(Color.white)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.cast) { cast in
                        VStack {
                            AsyncImage(url: URL(string: cast.profilePhoto)!) {
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
                            
                            Text("\(cast.name ?? "-") as \(cast.character ?? "-")")
                                .font(.caption)
                                .foregroundColor(Color.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)

                        }
                    }
                }
            }
        }.onAppear {
            movieManager.getCast(from: movie)
        }
    }
    
}

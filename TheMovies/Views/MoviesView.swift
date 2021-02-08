//
//  MoviesView.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import SwiftUI

struct MoviesView: View {
    
    @State private var searchTerm = ""
    @State private var selectionIndex = 0
    private var tabs = ["Now Playing", "Upcoming", "Popular"]
    
    @ObservedObject private var movieManager = MovieDownloadManager()
    
    init() {
        UITableView.appearance().backgroundColor      = .clear
        UITableViewCell.appearance().selectionStyle   = .none
        UINavigationBar.appearance().backgroundColor  = .clear
        UINavigationBar.appearance().tintColor        = .white
        UINavigationBar.appearance().barTintColor     = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                Text(self.tabs[selectionIndex])
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.top)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                    TextField("Search Term", text: $searchTerm)
                }
            }.padding(.horizontal)
            
            //Segmented Control
            
            VStack {
                Picker("-", selection: $selectionIndex) {
                    ForEach(0..<tabs.count) { index in
                        Text(self.tabs[index])
                            .font(.title)
                            .bold()
                            .tag(index)
                    }
                }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: selectionIndex, perform: { value in
                    if(selectionIndex == 0) {
                        movieManager.getnowPlaing()
                    } else if(selectionIndex == 1) {
                        movieManager.getUpComing()
                    } else if(selectionIndex == 2) {
                        movieManager.getPopular()
                    }
                })
            }.padding()
            
            //Create a List View
            
            List {
                ForEach(movieManager.movies.filter { self.searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(self.searchTerm.lowercased()) ?? true }) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieCell(movie: movie)
                    }.listRowBackground(Color.clear)
                }
            }.onAppear {
                movieManager.getnowPlaing()
            }
            
            Spacer()
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}

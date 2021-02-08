//
//  HomeTabView.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import SwiftUI

struct HomeTabView: View {
    
    enum Tab: Int {
        case movies
        case discover
    }
    
    @State private var selectedTab = Tab.movies
    
    var body: some View {
        TabView(selection: $selectedTab,
                content:  {
                    MoviesView().tabItem {
                        tabBarItem(with: "Movies", image: "film")
                    }
                    DiscoverView().tabItem {
                        tabBarItem(with: "Discover", image: "square.stack")
                    }
                })
    }
    
    private func tabBarItem(with title: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(title)
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView().previewDevice("iPhone 11")
    }
}

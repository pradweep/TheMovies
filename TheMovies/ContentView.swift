//
//  ContentView.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            Group {
               HomeTabView()
            }.navigationTitle("Movies")
            .navigationBarItems(trailing: HStack {
                SettingsButton
            })
            .sheet(isPresented: $showSheet, content: {
                SettingsView(isPreseneted: $showSheet)
            })
        }
    }
    
    private var SettingsButton: some View {
        Button(action: {
            self.showSheet.toggle()
        }, label: {
            HStack {
                Image(systemName: "gear")
                    .font(.headline)
                    .foregroundColor(Color.gray)
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewDevice("iPhone 11")
    }
}

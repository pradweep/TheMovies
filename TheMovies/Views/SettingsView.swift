//
//  SettingsView.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var selection = 1
    @State private var email = ""
    @Binding var isPreseneted: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Favorite Genre", selection: $selection) {
                    Text("Action").tag(1)
                    Text("Fiction").tag(2)
                    Text("Marvel").tag(2)
                    Text("Funny").tag(3)
                }
                
                Section(header: Text("Email")) {
                    TextField("Enter email", text: $email)
                }
                
                Button(action: {
                    isPreseneted.toggle()
                }, label: {
                    HStack {
                        Spacer()
                        Text("Save")
                        Spacer()
                    }
                })
            }.navigationTitle("Settings Page")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPreseneted: .constant(false))
    }
}

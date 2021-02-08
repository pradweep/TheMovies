//
//  AsyncImage.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import SwiftUI

struct AsyncImage<PlaceHolder: View>: View  {
    
    @StateObject private var imageLoader: ImageLoader
    
    private let placeholder: PlaceHolder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> PlaceHolder,
        @ViewBuilder image:@escaping (UIImage) -> Image = Image.init(uiImage:)
         ) {
        self.placeholder = placeholder()
        self.image = image
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url, imageCache: Environment.init(\.imageCache).wrappedValue))
    }
    
    
    var body: some View {
        content.onAppear(perform: imageLoader.load)
    }
    
    private var content: some View {
        
        Group {
            if(imageLoader.image != nil) {
                image(imageLoader.image!)
            } else {
                placeholder
            }
        }
        
    }
    
}

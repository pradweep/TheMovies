//
//  ImageLoader.swift
//  TheMovies
//
//  Created by Pradeep's Macbook on 07/02/21.
//

import UIKit
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var imageCache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, imageCache: ImageCache? = nil) {
        self.url = url
        self.imageCache = imageCache
    }
    
    deinit {
        cancel()
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    func load() {
        
        guard !isLoading else {
            return
        }
        
        if let image = imageCache?[url] {
            self.image = image
            return
        }
        
        cancellable =  URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data)}
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.onCache($0) } ,
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self]  in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func onCache(_ image: UIImage?) {
        image.map { imageCache?[url] = $0 }
    }
    
}


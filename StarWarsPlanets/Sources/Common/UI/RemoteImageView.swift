//
//  RemoteImageView.swift
//  StarWarsPlanets
//
//  Created by Dinitha Gamage on 2025-09-05.
//

import SwiftUI

/// A simple async remote image loader with in-memory + URLCache support
struct RemoteImageView: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder
    }

    var body: some View {
        content
            .onAppear { loader.load() }
    }

    private var content: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if loader.isLoading {
                ProgressView()
            } else {
                placeholder
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Image Loader

private class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false

    private let url: URL?
    private static let cache = NSCache<NSURL, UIImage>()

    init(url: URL?) {
        self.url = url
    }

    func load() {
        guard let url = url, image == nil else { return }

        if let cached = Self.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }

        isLoading = true
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let uiImage = UIImage(data: data) {
                    Self.cache.setObject(uiImage, forKey: url as NSURL)
                    await MainActor.run { self.image = uiImage }
                }
            } catch {
                // silently fail, placeholder will be shown
            }
            await MainActor.run { self.isLoading = false }
        }
    }
}

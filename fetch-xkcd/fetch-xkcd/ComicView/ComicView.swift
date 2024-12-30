//
//  ComicView.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

/**
 
 __Explanation of Choices
 
 - AsyncImage provides caching using URLCache.
 
 */

import SwiftUI

struct ComicView: View {
    @ObservedObject var viewModel: ComicViewModel
    
    var body: some View {
        VStack {
            if let comic = viewModel.comic {
                Text(comic.title)
                    .font(.helveticaSmallCapsBold21)
                Text(comic.date)
                AsyncImage(url: comic.imageUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .padding()
                    } else if let error = phase.error {
                        Text("Error loading image: \(error)")
                    } else {
                        ProgressView()
                    }
                }
                Spacer()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            } else {
                ProgressView()
            }
        }
        .task {
            await viewModel.getComic()
        }
        .onDisappear {
            viewModel.comic = nil
            viewModel.errorMessage = nil
        }
    }
}

#Preview {
    ContentView()
}

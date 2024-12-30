//
//  ContentView.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/28/24.
//

/**
 
 __Explanation of Choices
 
 - ViewModel is instantiated in `ContentView`, rather than `ComicView`, to prevent creating a new instance on each search.
 - `input` is held by `ContentView`, rather than ViewModel, because it's a UI element.
 - Error message Text View holds " " to retain proper spacing.
 - `errorMessage(input:)` is in the View, rather than ViewModel, because it's validating a UI element.
 - `Font.helveticaSmallCaps` is as close as I could get to the title font on `https://xkcd.com/`
 
*/

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ComicViewModel(comicService: ComicService())
    
    @State private var input: Int? = 1
    @State private var showComicView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                Spacer()
                InputView(value: $input, placeholder: "Enter a number", image: Image(systemName: "magnifyingglass"))
                    .keyboardType(.numberPad)
                Text(errorMessage(input: input) ?? " ")
                    .foregroundStyle(.red)
                Spacer()
                PrimaryButton(text: "Get Comic") {
                    viewModel.searchInput = input
                    showComicView = true
                }
            }
            .padding()
            .navigationDestination(isPresented: $showComicView) {
                ComicView(viewModel: viewModel)
            }
        }
    }
    
    private func errorMessage(input: Int?) -> String? {
        if let input, viewModel.isValidIndex(input) {
            return nil
        } else {
            return "Please enter a number between 1 and 2843."
        }
    }
}

#Preview {
    ContentView()
}

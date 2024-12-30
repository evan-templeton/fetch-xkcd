//
//  ComicViewModel.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

import SwiftUI

@MainActor
class ComicViewModel: ObservableObject {
    
    private let comicService: ComicServiceProtocol
    
    var searchInput: Int?
    
    @Published var comic: Comic?
    @Published var errorMessage: String?
    
    init(comicService: ComicServiceProtocol) {
        self.comicService = comicService
    }
    
    func getComic() async {
        do {
            comic = try await comicService.fetchComic(index: searchInput)
        } catch {
            guard let error = error as? ComicServiceError else {
                errorMessage = "Unknown error occurred."
                return
            }
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }
    
    func isValidIndex(_ index: Int) -> Bool {
        return ComicService.isValidIndex(index)
    }
}

//
//  fetch_xkcdTests.swift
//  fetch-xkcdTests
//
//  Created by Evan Templeton on 12/28/24.
//

import XCTest
@testable import fetch_xkcd

@MainActor
fileprivate final class fetch_xkcdTests: XCTestCase {

    var viewModel: ComicViewModel!
    var service: ComicServiceMock!
    
    override func setUp() {
        service = ComicServiceMock()
        viewModel = ComicViewModel(comicService: service)
    }
    
    func testFetchComic_successSetsComic() async {
        XCTAssertNil(viewModel.comic)
        XCTAssertNil(viewModel.errorMessage)
        await viewModel.getComic()
        XCTAssertNotNil(viewModel.comic)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchComic_failSetsErrorMessage() async {
        XCTAssertNil(viewModel.comic)
        XCTAssertNil(viewModel.errorMessage)
        service.fetchComicShouldThrowError = true
        await viewModel.getComic()
        XCTAssertNil(viewModel.comic)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    func testIsValidIndex_edges() {
        XCTAssertFalse(viewModel.isValidIndex(0))
        XCTAssertTrue(viewModel.isValidIndex(1))
        XCTAssertTrue(viewModel.isValidIndex(2843))
        XCTAssertFalse(viewModel.isValidIndex(2844))
    }
}

fileprivate class ComicServiceMock: ComicServiceProtocol {
    var fetchComicShouldThrowError = false
    func fetchComic(index: Int?) async throws -> Comic {
        if fetchComicShouldThrowError {
            throw ComicServiceError.httpConversion
        } else {
            return .mock
        }
    }
}

fileprivate extension Comic {
    static var mock: Comic {
        Comic(title: "title", imageUrl: URL(string: "https://xkcd.com")!, day: "23", month: "1", year: "2024")
    }
}

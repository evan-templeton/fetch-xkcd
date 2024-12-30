//
//  ComicService.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

import Foundation

protocol ComicServiceProtocol {
    func fetchComic(index: Int?) async throws -> Comic
}

enum ComicServiceError: LocalizedError {
    case invalidStatusCode(Int)
    case httpConversion
    
    var localizedDescription: String {
        switch self {
            case .invalidStatusCode(let code):
                return "Invalid status code \(code)"
            case .httpConversion:
                return "Could not convert URLResponse to HTTPResponse"
        }
    }
}

class ComicService: ComicServiceProtocol {
    
    func fetchComic(index: Int?) async throws -> Comic {
        let url = ComicService.url(for: index)
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ComicServiceError.httpConversion
        }
        
        switch httpResponse.statusCode {
            case 200:
                return try JSONDecoder().decode(Comic.self, from: data)
            default:
                throw ComicServiceError.invalidStatusCode(httpResponse.statusCode)
        }
    }
    
    static func isValidIndex(_ index: Int) -> Bool {
        return 1...2843 ~= index
    }
    
    private static func url(for index: Int?) -> URL {
        var path = "/info.0.json"
        if let index, Self.isValidIndex(index) {
            path = "/\(index)" + path
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "xkcd.com"
        components.path = path
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        return url
    }
}

//
//  Comic.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

import Foundation

struct Comic: Decodable {
    let title: String
    let imageUrl: URL
    private let day: String
    private let month: String
    private let year: String
    
    init(title: String, imageUrl: URL, day: String, month: String, year: String) {
        self.title = title
        self.imageUrl = imageUrl
        self.day = day
        self.month = month
        self.year = year
    }
    
    var date: String {
        "\(month)-\(day)-\(year)"
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageUrl = "img"
        case day
        case month
        case year
    }
}

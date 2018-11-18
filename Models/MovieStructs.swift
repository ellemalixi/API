//
//  MovieStructs.swift
//  MovieAPICall2
//
//  Created by Michelle M on 18/11/2018.
//  Copyright © 2018 batgirl. All rights reserved.
//

import Foundation

// MARK: - STRUCTS
struct Movies: Decodable {
    var Title: String?
    var Year: String?
    var imdbID: String?
    var movieType: String?
    var Poster: String?
}

struct MoviesMain: Decodable {
    var Search: [Movies?]?
    var totalResults: String?
    var Response: String?
}

struct MoviesFormatted {
    var title: String
    var year: String
    var imdbID: String
    var movieType: String
    var poster: String
}


//
//  NetworkingConstant.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import Foundation

struct NetworkingConstant {
    static let baseUrl = "https://api.themoviedb.org/"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZDU1ZTIyZmJjNmFhY2I5ZTAwMTFiNTcwN2U4MmM2MiIsInN1YiI6IjY1YjJjNGJiZGJjYWRlMDBjODkyYTQ2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.HOhaI_OPLICfL4PQ2xnhrzgm7wEbexTcgHX1s3KyBFI"
}

typealias DefaultResponse<R: Decodable> = TMDBMoviesDefaultResponseModel<R>

struct TMDBMoviesDefaultResponseModel<R: Decodable>: Decodable {
    let page: Int
    let results: R
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

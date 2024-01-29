//
//  ListMovieRepository.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation

protocol ListMoviesRepositoryProtocol {
    func getListMovies(page: Int, completion: @escaping (ListMoviesResponse?, Error?) -> Void)
}

class ListMoviesRepository: ListMoviesRepositoryProtocol {
    let baseUrl = Constants.UrlConstants.url
    private let dataSource: ServiceDataProtocol?

    init() {
        self.dataSource = ServiceData()
    }

    func getListMovies(page: Int, completion: @escaping (ListMoviesResponse?, Error?) -> Void) {
        let urlPath = baseUrl + Constants.UrlConstants.urlMovie + "?page=\(page)&api_key=" + Constants.UrlConstants.apiKey
        self.dataSource?.getServiceRequest(url: urlPath) { (result) in
            switch result {
            case .success(let movies):
                guard let moviesResponse = try? JSONDecoder().decode(ListMoviesResponse?.self, from: movies as! Data) else {
                    let newError = ErrorModel(code: 0, description: "Error desconocido")
                    completion(nil, newError)
                    return
                }
                completion(moviesResponse, nil)
            case .failure(let error):
                let newError = ErrorModel(code: error.code, description: error.localizedDescription)

                completion(nil, newError)
            }
        }
    }
}

//
//  ListMoviesInteractor.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation

protocol ListMoviesInteractorProtocol {
    func getListMovies(pageList: Int)
}

class ListMoviesInteractor: ListMoviesInteractorProtocol {
    var presenter: ListMoviesPresenterProtocol?
    var repository: ListMoviesRepositoryProtocol?

    init(presenter: ListMoviesPresenterProtocol) {
        self.presenter = presenter
        self.repository = ListMoviesRepository()
    }

    func getListMovies(pageList: Int) {
        self.repository?.getListMovies(page: pageList) { (response, error) in
            if let listMoviesResponse = response {
                self.presenter?.didGetListMovies(list: listMoviesResponse)
            }
            if let error = error {
                self.presenter?.errorGetListMovies(error: error as! ErrorModel)
            }
        }
    }
}

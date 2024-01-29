//
//  ListMoviesPresenter.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation

protocol ListMoviesPresenterProtocol {
    func getListMovies()
    func didGetListMovies(list: ListMoviesResponse)
    func errorGetListMovies(error: ErrorModel)

    func getMovies() -> [ListMoviesModel]
    func getSearchMovies() -> [ListMoviesModel]
    func putNewSearchMoview(movie: ListMoviesModel)
    func setSearchMovies(movies: [ListMoviesModel])
    func clearSearchMovies()
    func getPage() -> Int
    func getTotalPages() -> Int

    func saveListMovies(movie: ListMoviesModel)
    func goToDetailMovies(movie: ListMoviesModel)
}

class ListMoviesPresenter: ListMoviesPresenterProtocol {
    weak var listMoviesView: ListMoviesViewProtocol!
    var interactor: ListMoviesInteractorProtocol?
    var router: ListMoviesRouterProtocol?

    var movieList: [ListMoviesModel] = []
    var searchMovieList: [ListMoviesModel] = []
    var totalPagesList: Int = 0
    var page: Int = 0

    init(view: ListMoviesViewProtocol) {
        listMoviesView = view
        interactor = ListMoviesInteractor(presenter: self)
        router = ListMoviesRouter(withView: self.listMoviesView)
    }

    func getListMovies() {
        interactor?.getListMovies(pageList: self.page + 1)
    }

    func didGetListMovies(list: ListMoviesResponse) {
        movieList.append(contentsOf: list.results ?? [])
        searchMovieList.append(contentsOf: list.results ?? [])
        totalPagesList = list.total_pages ?? 0
        page = list.page ?? 0

        listMoviesView.showListMovie(saved: false)
    }

    func errorGetListMovies(error: ErrorModel) {
        movieList.removeAll()
        searchMovieList.removeAll()
        
        let savedMovies = DataManager.shared.moviesCore()
        if !savedMovies.isEmpty {
            for savedMovie in savedMovies {
                var movie = ListMoviesModel()
                movie.id = Int(savedMovie.id)
                movie.title = savedMovie.title
                movie.original_title = savedMovie.original_title
                movie.release_date = savedMovie.release_date
                movie.overview = savedMovie.overview
                movie.vote_average = savedMovie.vote_average
                movie.poster_path = savedMovie.poster_path

                movieList.append(movie)
                searchMovieList.append(movie)
            }
            listMoviesView.showListMovie(saved: true)
        }
        listMoviesView.showAlert(title: "Error", message: error.localizedDescription)
    }

    func goToDetailMovies(movie: ListMoviesModel) {
        let movieViewModel = ListMovieViewModel(title: movie.title,
                                       poster: "\(Constants.UrlConstants.imageUrl)\(movie.poster_path ?? "")",
                                       voteAverage: movie.vote_average,
                                       releaseDate: movie.release_date,
                                       overview: movie.overview)
        
        router?.goToDetailMovies(listMoviesViewModel: movieViewModel)        
    }

    func getMovies() -> [ListMoviesModel] {
        return movieList
    }

    func getSearchMovies() -> [ListMoviesModel] {
        return searchMovieList
    }

    func clearSearchMovies() {
        searchMovieList.removeAll()
    }

    func putNewSearchMoview(movie: ListMoviesModel) {
        searchMovieList.append(movie)
    }

    func setSearchMovies(movies: [ListMoviesModel]) {
        searchMovieList.removeAll()
        searchMovieList.append(contentsOf: movies)
    }

    func getPage() -> Int {
        return page
    }

    func getTotalPages() -> Int {
        return totalPagesList
    }

    func saveListMovies(movie: ListMoviesModel) {
        _ = DataManager.shared.movieCoreData(
            id: Int64(movie.id ?? 0),
            title: movie.title ?? "",
            original_title: movie.original_title ?? "",
            overview: movie.overview ?? "",
            release_date: movie.release_date ?? "",
            poster_path: movie.poster_path ?? "",
            vote_average: movie.vote_average ?? 0)
        DataManager.shared.saveMovies()
    }
}

//
//  ListMoviesRouter.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation
import UIKit

protocol ListMoviesRouterProtocol {
    func goToDetailMovies(listMoviesViewModel: ListMovieViewModel)
}

class ListMoviesRouter {
    private weak var moviesViewProtocol: ListMoviesViewProtocol!

    init(withView view: ListMoviesViewProtocol) {
        self.moviesViewProtocol = view
    }
}

extension ListMoviesRouter: ListMoviesRouterProtocol {
    func goToDetailMovies(listMoviesViewModel: ListMovieViewModel) {
        let originViewController = self.moviesViewProtocol as! ListMoviesViewController
        let destinyViewController = Build.toDetailMovies(movieDetail: listMoviesViewModel)
        originViewController.navigationController?.pushViewController(destinyViewController, animated: true)
    }
}

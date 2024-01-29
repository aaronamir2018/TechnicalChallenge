//
//  LoginMoviesConfigurator.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 26/01/24.
//

import Foundation

protocol LoginMoviesConfiguratorProtocol {
    func configureMovies(viewController: LoginMoviesViewController)
}

class LoginMoviesConfigurator: LoginMoviesConfiguratorProtocol {
    func configureMovies(viewController: LoginMoviesViewController) {
        viewController.presenter = LoginMoviesPresenter(view: viewController)
    }
}

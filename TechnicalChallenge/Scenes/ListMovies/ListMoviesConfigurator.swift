//
//  ListMoviesConfigurator.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation

protocol ListMoviesConfiguratorProtocol {
    func configure(viewController: ListMoviesViewController)
}

class ListMoviesConfigurator: ListMoviesConfiguratorProtocol {
    func configure(viewController: ListMoviesViewController) {
        viewController.presenter = ListMoviesPresenter(view: viewController)
    }
}

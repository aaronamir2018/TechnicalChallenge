//
//  UpcomingMoviesConfigurator.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 24/01/24.
//

import Foundation

final class UpcomingMoviesConfigurator {
    
    static func injectDependencies(for viewController: UpcomingMoviesViewController) {
        let interactor = UpcomingMoviesInteractor()
        let networkWorker = UpcomingMoviesNetworkingWorker()
        let presenter = UpcomingMoviesPresenter()
        
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        interactor.networkWorker = networkWorker
        
        
         presenter.view = viewController
    }
}

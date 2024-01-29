//
//  LoginMoviesRouter.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 26/01/24.
//

import Foundation

protocol LoginMoviesRouterProtocol {
    func goToListMovies()
    func showError(title: String, message: String)
}

class LoginMoviesRouter {
    private weak var loginMoviesProtocol: LoginMoviesViewProtocol!
    
    init(withView view: LoginMoviesViewProtocol) {
        self.loginMoviesProtocol = view
    }
}

extension LoginMoviesRouter: LoginMoviesRouterProtocol {
    func goToListMovies() {
        let viewController = self.loginMoviesProtocol as! LoginMoviesViewController
        let segueTo = Build.toListMovies()
        viewController.navigationController?.pushViewController(segueTo, animated: true)
    }
    
    func showError(title: String, message: String) {
        let alertVC = Alerts.showAlert(title: title, message: message)
        let viewController = self.loginMoviesProtocol as! LoginMoviesViewController
        viewController.present(alertVC, animated: true, completion: nil)
    }
}

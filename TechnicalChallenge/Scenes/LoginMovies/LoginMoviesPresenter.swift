//
//  LoginMoviesPresenter.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 26/01/24.
//

import UIKit
import CoreData

protocol LoginMoviesPresenterProtocol {
    func goValidateUser(userName: String?, password: String?)
    func goToListMovies()
    func goToShowError(title: String, message: String)
}

class LoginMoviesPresenter: LoginMoviesPresenterProtocol {
    weak var loginView: LoginMoviesViewProtocol!
    var interactor: LoginMoviesInteractorProtocol?
    var router: LoginMoviesRouterProtocol?
    
    init(view: LoginMoviesViewProtocol) {
        self.loginView = view
        self.interactor = LoginMoviesInteractor()
        self.router = LoginMoviesRouter(withView: self.loginView)
    }
    
    func goValidateUser(userName: String?, password: String?) {
        let isValidUser = self.interactor?.getValidation(userRequest: UserRequest(userName: userName ?? "", password: password ?? "")) ?? false
        if isValidUser {
            self.loginView.showListMovies()
        } else {
            loginView.showAlert(title: Constants.AlertContants.titleError, message: Constants.AlertContants.message)
        }
    }
    
    func goToListMovies() {
        self.router?.goToListMovies()
    }
    
    func goToShowError(title: String, message: String) {
        self.router?.showError(title: title, message: message)
    }
}

//
//  LoginMoviesPresenter.swift
//  TechnicalChallenge
//
//  Created by Luis Purizaga on 26/01/24.
//

import UIKit

protocol LoginMoviesPresentationLogic {
    func presentLogin(response: Login.Login.Response)
}


class LoginMoviesPresenter: LoginMoviesPresentationLogic {
    weak var viewController: LoginMoviesDisplayLogic?
    
    func presentLogin(response: Login.Login.Response) {
        let viewModel = Login.Login.ViewModelSuccess(succesMessage: "Entro")
    }
}

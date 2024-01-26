//
//  LoginMoviewInteractor.swift
//  TechnicalChallenge
//
//  Created by Luis Purizaga on 26/01/24.
//

import UIKit

protocol LoginMoviesBusinessLogic {
    func login(request: Login.Login.Request)
}
 
class LoginMovieInteractor: LoginMoviesBusinessLogic {
    var presenter: LoginMoviesPresentationLogic?

    func login(request: Login.Login.Request) {

    }
}

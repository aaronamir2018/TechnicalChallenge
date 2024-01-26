//
//  LoginMoviesRouter.swift
//  TechnicalChallenge
//
//  Created by Luis Purizaga on 26/01/24.
//

import UIKit

protocol LoginMoviesRoutingLogic {
    func routeToNextScreen(segue: UIStoryboardSegue?)
}

class LoginMoviesRouter: NSObject, LoginMoviesRoutingLogic {
    weak var viewController: UpcomingMoviesViewController?
    
    func routeToNextScreen(segue: UIStoryboardSegue?) {
    }
}

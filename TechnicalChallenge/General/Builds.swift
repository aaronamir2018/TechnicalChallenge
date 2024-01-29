//
//  Builds.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 28/01/24.
//

import Foundation
import UIKit

enum Build {
    static func toListMovies() -> UIViewController {
        let storyboard = UIStoryboard(name: Constants.StoryboardName.listMoviesView, bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.listMoviesViewController)
        return navController
    }
    
    static func toDetailMovies(movieDetail: ListMovieViewModel) -> UIViewController {
        let storyboard = UIStoryboard(name: Constants.StoryboardName.detailMoviesView, bundle: nil)
        let detailMovieViewController = storyboard.instantiateViewController(withIdentifier: Constants.ViewControllerIdentifier.detailMoviesViewController) as! DetailMoviesViewController
            detailMovieViewController.movieDetailViewModel = movieDetail
            return detailMovieViewController
    }
}

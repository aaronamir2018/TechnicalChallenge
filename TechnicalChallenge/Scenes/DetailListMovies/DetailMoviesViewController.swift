//
//  DetailMoviesViewController.swift
//  TechnicalChallenge
//
//  Created by Aaron Cordero on 26/01/24.
//

import UIKit
import Kingfisher

class DetailMoviesViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var noteMovieLabel: UILabel!
    @IBOutlet weak var releaseDateMovieLabel: UILabel!
    @IBOutlet weak var summaryMovieLabel: UILabel!
    
    var movieDetailViewModel: ListMovieViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {        
        nameMovieLabel.text = movieDetailViewModel?.title
        noteMovieLabel.text = movieDetailViewModel?.voteAverage?.description
        releaseDateMovieLabel.text = movieDetailViewModel?.releaseDate
        summaryMovieLabel.text = movieDetailViewModel?.overview

        if let url = URL(string: (movieDetailViewModel?.poster)!) {
            movieImage.kf.setImage(with: url, options: [.transition(.fade(0.5))])
        }
    }
}
